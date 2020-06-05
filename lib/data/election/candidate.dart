import 'person.dart';

class Candidate {
  final int id;
  final String nation;
  final String spouse;
  final String bio;
  final Person person;

  Candidate({this.id, this.nation, this.spouse, this.bio, this.person});

  Candidate.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] == null ? 1 : parsedJson['id'],
        nation = parsedJson['nation'],
        spouse = parsedJson['spouse'],
        bio = parsedJson['bio'],
        person = Person.fromJson(parsedJson['person']);
}
