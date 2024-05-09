import 'package:dentist_directory/screens/add_patient_screen.dart';
import 'package:dentist_directory/screens/view_patient_screen.dart';
import 'package:dentist_directory/screens/sign_in_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../res/custom_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'AR'),
        startLocale: const Locale('ar', 'AR'),
        useOnlyLangCode: true,
        saveLocale: true,
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dentist Directory',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        // primarySwatch: Colors.grey,
        // brightness: Brightness.dark,
        unselectedWidgetColor: const Color(0xFF333333),
        primaryColor: const Color(0xFFffffff),
        primaryColorDark: const Color(0xFF813892),
        primaryColorLight: const Color(0xFFC7C7C6),
        indicatorColor: const Color(0xFF333333),
        highlightColor: const Color(0xFFffffff),
        // dialogBackgroundColor: const Color(0xFFf9f9f9),
        cardColor: const Color(0xFFfbfbfb),
        scaffoldBackgroundColor: const Color(0xFFffffff),
        splashColor: const Color(0xFFffffff),
        tabBarTheme: const TabBarTheme(
            labelColor: Color(0xFF813892),
            labelStyle: TextStyle(color: Color(0xFF813892)), // color for text
            indicator: UnderlineTabIndicator(
                // color for indicator (underline)
                borderSide: BorderSide(color: Color(0xFF813892)))),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF813892), circularTrackColor: Color(0xFFC7C7C6)),
        // textTheme: const TextTheme(
        //   displayLarge: TextStyle(
        //       color: Color(0xFF813892),
        //       fontSize: 19.0,
        //       fontWeight: FontWeight.bold),
        //   displayMedium: TextStyle(
        //       color: Color(0xFFC7C7C6),
        //       fontSize: 19.0,
        //       fontWeight: FontWeight.bold),
        //   displaySmall: TextStyle(
        //       color: Color(0xFF813892),
        //       fontSize: 19.0,
        //       fontWeight: FontWeight.normal),
        //   headlineMedium: TextStyle(
        //       color: Color(0xFFC7C7C6),
        //       fontSize: 19.0,
        //       fontWeight: FontWeight.normal),
        //   headlineSmall: TextStyle(
        //       color: Color(0xFFFFFFFF),
        //       fontSize: 19.0,
        //       fontWeight: FontWeight.normal),
        //   titleLarge: TextStyle(
        //       color: Color(0xFFFFFFFF),
        //       fontSize: 13.0,
        //       fontWeight: FontWeight.normal),
        //   bodyLarge: TextStyle(
        //       color: Color(0xFF813892),
        //       fontSize: 18.0,
        //       fontWeight: FontWeight.bold),
        //   bodyMedium: TextStyle(
        //       color: Color(0xFFFFFFFF),
        //       fontSize: 13.0,
        //       fontWeight: FontWeight.bold),
        //   titleMedium: TextStyle(
        //       color: Color(0xFF813892),
        //       fontSize: 13.0,
        //       fontWeight: FontWeight.normal),
        //   titleSmall: TextStyle(
        //       color: Color(0xFF813892),
        //       fontSize: 16.0,
        //       fontWeight: FontWeight.bold),
        // ),
        // inputDecorationTheme: const InputDecorationTheme(
        //   floatingLabelAlignment: FloatingLabelAlignment.start,
        //   contentPadding:
        //       EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0, bottom: 10.0),
        //   helperMaxLines: 1,
        //   // isDense: true,
        //   filled: true,
        //   // fillColor: Colors.blue,
        //   fillColor: Color(0xFFECEFF1),
        //   focusColor: Color(0xFFfbfbfb),
        //   hoverColor: Color(0xFFfbfbfb),
        //   //lite gray
        //   iconColor: Color(0xFFC7C7C6),
        //   suffixIconColor: Color(0xFFC7C7C6),
        //   prefixIconColor: Color(0xFFC7C7C6),
        //   hintStyle: TextStyle(
        //       fontSize: 13,
        //       color: Color(0xFF333333),
        //       fontWeight: FontWeight.normal),
        //   floatingLabelStyle: TextStyle(
        //       fontSize: 13, color: Colors.grey, fontWeight: FontWeight.normal),
        //   labelStyle: TextStyle(
        //       fontSize: 16,
        //       color:  Colors.red,
        //       fontWeight: FontWeight.normal),
        //   counterStyle: TextStyle(
        //       fontSize: 13, color: Colors.red, fontWeight: FontWeight.normal),
        //   // border: InputBorder.none,
        //   // enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.white)),
        //   enabledBorder: UnderlineInputBorder(
        //     // borderRadius: BorderRadius.all(Radius.circular(10)),
        //     borderSide: BorderSide(
        //         color: Color(0xFFC7C7C6), width: 0.8, style: BorderStyle.solid),
        //   ),
        //   // focusedBorder:  OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide( color: Colors.blue)),
        //   focusedBorder: UnderlineInputBorder(
        //     // borderRadius: BorderRadius.all(Radius.circular(50)),
        //     borderSide: BorderSide(
        //         color: Colors.grey, width: 1.5, style: BorderStyle.solid),
        //   ),
        //   errorBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //         color: Colors.red, width: 1.5, style: BorderStyle.solid),
        //   ),
        //   border: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //         color: Color(0xFFC7C7C6), width: 1.5, style: BorderStyle.solid),
        //   ),
        //   errorStyle: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal),
        // ),
      ),
      home:  const SignInScreen(),
    );
  }
}
