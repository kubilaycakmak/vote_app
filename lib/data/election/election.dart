import 'party_list.dart';
import 'score_list.dart';

class Election {
  final String dateStart;
  final String dateEnd;
  final String createdBy;
  final String description;
  final PartyList parties;
  final ScoreList score;

  Election({
    this.dateStart,
    this.dateEnd,
    this.createdBy,
    this.description,
    this.parties,
    this.score,
  });

  Election.fromJson(Map<String, dynamic> parsedJson)
      : dateStart = parsedJson['dateStart'],
        dateEnd = parsedJson['dateEnd'],
        createdBy = parsedJson['createdBy'],
        description = parsedJson['description'],
        parties = PartyList.fromJson(parsedJson['parties']),
        score = ScoreList.fromJson(parsedJson['score']);
}
