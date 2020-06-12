import 'package:vote_app/data/election/role_list.dart';

class AuthPerson {
  final int id;
  final String username;
  final String email;
  final List<String> roleList;
  final String tokenType;
  final String accessToken;

  AuthPerson(
      {this.id,
      this.username,
      this.email,
      this.roleList,
      this.tokenType,
      this.accessToken});

  AuthPerson.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        roleList = (json['roles']).cast<String>(),
        tokenType = json['tokenType'],
        accessToken = json['accessToken'];
}
