import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:vote_app/data/election/election_list.dart';

Future<ElectionList> getElectionInformation() async {
  var response = await http.get('http://192.168.1.7:8080/api/test/election');
  print(response.statusCode);
  if (response.statusCode == 200) {
    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    return ElectionList.fromJson(data);
  } else {
    throw Exception("Failed to load Election Information // api/test/election");
  }
}
