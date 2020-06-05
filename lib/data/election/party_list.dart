import 'party.dart';

class PartyList {
  final List<Party> parties;

  PartyList({this.parties});
  factory PartyList.fromJson(List<dynamic> parsedJson) {
    List<Party> party = new List<Party>();

    party = parsedJson.map((e) => Party.fromJson(e)).toList();

    return new PartyList(
      parties: party,
    );
  }
}
