import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:vote_app/data/election/election_list.dart';

Future<ElectionList> getElectionInformation() async {
  var response = await http.get('http://192.168.1.2:8080/api/test/election');
  if (response.statusCode == 200) {
    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    return ElectionList.fromJson(data);
  } else {
    throw Exception("Failed to load Election Information // api/test/election");
  }
}

Future<String> useVote({int electionId, int partyId, int personId}) async {
  var url = 'http://192.168.1.2:8080/api/test/use/vote';
  Map body = {
    'election_id': electionId,
    'party_id': partyId,
    'person_id': personId
  };

  var encodedBody = json.encode(body);
  var response = await http.post(
    url,
    body: encodedBody,
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    return response.body;
  }
}
