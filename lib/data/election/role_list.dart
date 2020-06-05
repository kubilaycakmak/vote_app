import 'role.dart';

class RoleList {
  final List<Role> roles;

  RoleList({this.roles});

  factory RoleList.fromJson(List<dynamic> parsedJson) {
    List<Role> roles = new List<Role>();

    roles = parsedJson.map((e) => Role.fromJson(e)).toList();

    return new RoleList(
      roles: roles,
    );
  }
}
