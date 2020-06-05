import 'election.dart';

class ElectionList {
  final List<Election> elections;

  ElectionList({this.elections});

  factory ElectionList.fromJson(List<dynamic> parsedJson) {
    List<Election> elections = new List<Election>();
    elections = parsedJson.map((e) => Election.fromJson(e)).toList();

    return new ElectionList(
      elections: elections,
    );
  }
}
