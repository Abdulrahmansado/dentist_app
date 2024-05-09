
class Patient {
  String? _id;
  String? _first_name;
  String? _last_name;
  String? _date_of_birth;
  String? _phone_number;
  String? _page_number;
  String? _id_user_created;

  Patient(this._id, this._first_name, this._last_name, this._date_of_birth, this._phone_number, this._page_number, this._id_user_created);
  Patient.empty(this._first_name, this._last_name, this._date_of_birth, this._phone_number, this._page_number, this._id_user_created);


  // Getters
  String? get id => _id;

  String? get firstName => _first_name;
  String? get lastName => _last_name;
  String? get dateOfBirth => _date_of_birth;
  String? get phoneNumber => _phone_number;
  String? get pageNumber => _page_number;
  String? get idUserCreated => _id_user_created;

  // Setters

  set id(id) {
    _id = id;
  }

  set firstName(value) {
    _first_name = value;
  }

  set lastName(value) {
    _last_name = value;
  }

  set dateOfBirth(value) {
    _date_of_birth = value;
  }

  set phoneNumber(value) {
    _phone_number = value;
  }

  set pageNumber(value) {
    _page_number = value;
  }

  set idUserCreated(value) {
    _id_user_created = value;
  }

  // Convert a Patient object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = _id;
    }
    map['first_name'] = _first_name;
    map['last_name'] = _last_name;
    map['date_of_birth'] = _date_of_birth;
    map['phone_number'] = _phone_number;
    map['page_number'] = _page_number;
    map['id_user_created'] = _id_user_created;
    return map;
  }

  // Extract a Patient object from a Map object
  Patient.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _first_name = map['first_name'];
    _last_name = map['last_name'];
    _date_of_birth = map['date_of_birth'];
    _phone_number = map['phone_number'];
    _page_number = map['page_number'];
    _id_user_created = map['id_user_created'];
  }
}