import 'package:dentist_directory/screens/add_patient_screen.dart';
import 'package:dentist_directory/screens/sign_in_screen.dart';
import 'package:dentist_directory/screens/update_patient_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/patient.dart';
import '../res/custom_colors.dart';
import '../utils/authentication.dart';
import '../utils/firestore.dart';

class ViewPatientScreen extends StatefulWidget {
  final User _user;

  const ViewPatientScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  @override
  State<ViewPatientScreen> createState() => _ViewPatientScreenState();
}

class _ViewPatientScreenState extends State<ViewPatientScreen> {
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];
  late PlutoGridStateManager stateManager;

  bool _isLoaded = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    columns = [
      PlutoColumn(
        title: 'patient_page.first_name'.tr(),
        field: 'first_name',
        type: PlutoColumnType.text(),
        enableRowChecked: false,
        enableRowDrag: false,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'patient_page.last_name'.tr(),
        field: 'last_name',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'patient_page.page_number'.tr(),
        field: 'page_number',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'patient_page.date_of_birth'.tr(),
        field: 'date_of_birth',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'patient_page.phone_number'.tr(),
        field: 'phone_number',
        type: PlutoColumnType.text(),
        textAlign: PlutoColumnTextAlign.start,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
      ),
      PlutoColumn(
        title: 'general.update'.tr(),
        field: 'id_update',
        type: PlutoColumnType.text(),
        enableFilterMenuItem: false,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 75,
        minWidth: 75,
        renderer: (rendererContext) {
          return IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {
              // rendererContext.stateManager.insertRows(
              //   rendererContext.rowIdx,
              //   [rendererContext.stateManager.getNewRow()],
              // );
              var navigator = Navigator.of(context);
              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => UpdatePatientScreen(
                    patientId:
                        rendererContext.row.cells.entries.last.value.value,
                    user: widget._user,
                  ),
                ),
              );
            },
            iconSize: 18,
            color: Colors.green,
            padding: const EdgeInsets.all(0),
          );
        },
      ),
      PlutoColumn(
        title: 'general.delete'.tr(),
        field: 'id_delete',
        type: PlutoColumnType.text(),
        enableFilterMenuItem: false,
        enableEditingMode: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        width: 75,
        minWidth: 75,
        renderer: (rendererContext) {
          return IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title:
                        Text('patient_page.delete_patient_dialog_title'.tr()),
                    content: Text('patient_page.delete_patient_msg'.tr()),
                    actions: <Widget>[
                      TextButton(
                        child: Text('general.cancel'.tr()),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Dismiss the dialog when the 'Cancel' button is pressed
                        },
                      ),
                      TextButton(
                        child: Text('general.ok'.tr()),
                        onPressed: () async {
                          var navigator = Navigator.of(context);
                          await FireStore.deleteEntry(
                              'patient',
                              rendererContext
                                  .row.cells.entries.last.value.value);
                          rendererContext.stateManager
                              .removeRows([rendererContext.row]);
                          navigator.pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            iconSize: 18,
            color: Colors.red,
            padding: const EdgeInsets.all(0),
          );
        },
      ),
    ];
    fetchRows();
  }

  Future<List<Patient>> getData(String idUser) async {
    List<Patient> result = [];
    try {
      result = await FireStore.getAllEntriesSortedByName('patient', idUser);
    } catch (error) {
      // executed for errors of all types other than Exception
      print(error);
      // showErrorAlert(context, error);
    }
    // print(result);
    return result;
  }

  Future<List<PlutoRow>> fetchRows() async {
    final List<PlutoRow> _rows = [];
    _prefs.then((SharedPreferences prefs) async {
      String userId = prefs.getString('uid') ?? '';
      await getData(userId).then((data) {
        for (var item in data) {
          Map<String, PlutoCell> cells = {};
          cells['first_name'] = PlutoCell(value: item.firstName);
          cells['last_name'] = PlutoCell(value: item.lastName);
          cells['page_number'] = PlutoCell(value: item.pageNumber);
          cells['date_of_birth'] = PlutoCell(value: item.dateOfBirth);
          cells['phone_number'] = PlutoCell(value: item.phoneNumber);
          cells['id_update'] = PlutoCell(value: item.id);
          cells['id_delete'] = PlutoCell(value: item.id);
          _rows.add(PlutoRow(cells: cells));
        }
      });
      setState(() {
        rows = _rows;
        _isLoaded = true;
      });
    });
    return _rows;
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Text(
                      widget._user.displayName!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    widget._user.photoURL != null
                        ? ClipOval(
                            child: Material(
                              color: CustomColors.firebaseGrey.withOpacity(0.3),
                              child: Image.network(
                                widget._user.photoURL!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : ClipOval(
                            child: Material(
                              color: CustomColors.firebaseGrey.withOpacity(0.3),
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.person,
                                  size: 60,
                                  color: CustomColors.firebaseGrey,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('general.sign_out'.tr()),
              onTap: () async {
                final navigator = Navigator.of(context);
                await Authentication.signOut(context: context);
                navigator.pushReplacement(_routeToSignInScreen());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('general.patients_list'.tr()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var navigator = Navigator.of(context);
          navigator.pushReplacement(
            MaterialPageRoute(
              builder: (context) => AddPatientScreen(
                user: widget._user,
              ),
            ),
          );
        },
        tooltip: 'patient_page.add_patient'.tr(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: !_isLoaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PlutoGrid(
                columns: columns,
                rows: rows,
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);
                },
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager.setSelectingMode(PlutoGridSelectingMode.cell);
                  stateManager.setShowColumnFilter(true);
                },
                createFooter: (stateManager) {
                  stateManager.setPageSize(20, notify: false); // default 40
                  return PlutoPagination(stateManager);
                },
                rowColorCallback: (rowColorContext) {
                  int rowIndex = rowColorContext.rowIdx;

                  if (rowIndex % 2 == 0) {
                    return Colors.blue.shade100;
                  } else {
                    return Colors.blue.shade50;
                  }
                },
                configuration: const PlutoGridConfiguration(
                  columnSize: PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none,
                    resizeMode: PlutoResizeMode.normal,
                  ),
                  localeText: PlutoGridLocaleText(
                    filterContains: 'بحث',
                  ),
                ),
              ),
      ),
    );
  }
}
