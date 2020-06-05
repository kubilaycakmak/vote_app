import 'party_list.dart';
import 'score_list.dart';

class Election {
  final String dateStart;
  final String dateEnd;
  final String createdBy;
  final String description;
  final PartyList parties;
  final ScoreList score;
  final int electionId;

  Election(
      {this.dateStart,
      this.dateEnd,
      this.createdBy,
      this.description,
      this.parties,
      this.score,
      this.electionId});

  Election.fromJson(Map<String, dynamic> parsedJson)
      : dateStart = parsedJson['dateStart'],
        dateEnd = parsedJson['dateEnd'],
        createdBy = parsedJson['createdBy'],
        description = parsedJson['description'],
        parties = PartyList.fromJson(parsedJson['parties']),
        score = ScoreList.fromJson(parsedJson['score']),
        electionId = parsedJson['election_id'];
}
