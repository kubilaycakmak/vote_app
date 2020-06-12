import 'package:vote_app/data/election/person.dart';

class Party {
  final int id;
  final String name;
  final String dateOfFoundation;
  final String ideology;
  final Person candidate;

  Party(
      {this.id,
      this.name,
      this.dateOfFoundation,
      this.ideology,
      this.candidate});

  Party.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] == null ? 1 : parsedJson['id'],
        name = parsedJson['name'],
        dateOfFoundation = parsedJson['dateOfFoundation'],
        ideology = parsedJson['ideology'],
        candidate = Person.fromJson(parsedJson['candidate']);
}
