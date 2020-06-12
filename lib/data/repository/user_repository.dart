import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:vote_app/data/auth/auth_person.dart';
import 'package:vote_app/data/verify/verify_model.dart';

Map token;
AuthPerson person;

Future<String> signin(
    {@required String email, @required String password}) async {
  final signURL = "http://192.168.1.2:8080/api/auth/signin";
  Map signdata = {'email': email.toString(), 'password': password.toString()};
  var body = json.encode(signdata);
  var response = await http.post(
    signURL,
    body: body,
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    token = json.decode(response.body);
    person = new AuthPerson.fromJson(token);
    print(person.id);
    return token['accessToken'];
  } else {
    return 'unsuccessful';
  }
}

Future<Verify> verify({@required String filename}) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("http://192.168.1.2:5002/face_rec"),
  );
  request.files.add(
    http.MultipartFile.fromBytes('image', File(filename).readAsBytesSync(),
        filename: filename.split("/").last),
  );
  var res = await request.send();
  final respStr = await res.stream.bytesToString();
  var lastShape = json.decode(respStr);
  return Verify.fromJson(lastShape);
}
