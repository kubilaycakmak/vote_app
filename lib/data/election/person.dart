import 'package:vote_app/data/election/role_list.dart';

import 'address.dart';

class Person {
  final int id;
  final String name;
  final String surname;
  final String password;
  final String gender;
  final String email;
  final String lastIP;
  final String lastDevice;
  final String lastLocation;
  final Address address;
  final int age;
  final int nationId;
  final RoleList roleSet;

  Person({
    this.id,
    this.name,
    this.surname,
    this.password,
    this.gender,
    this.email,
    this.lastIP,
    this.lastDevice,
    this.lastLocation,
    this.address,
    this.age,
    this.nationId,
    this.roleSet,
  });

  Person.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] == null ? 1 : parsedJson['id'],
        name = parsedJson['name'],
        surname = parsedJson['surname'],
        password = parsedJson['password'],
        gender = parsedJson['gender'],
        email = parsedJson['email'],
        lastIP = parsedJson['lastIP'],
        lastDevice = parsedJson['lastDevice'],
        lastLocation = parsedJson['lastLocation'],
        address = Address.fromJson(parsedJson['address']),
        age = parsedJson['age'],
        nationId = parsedJson['nationId'],
        roleSet = RoleList.fromJson(parsedJson['roleSet']);
}
