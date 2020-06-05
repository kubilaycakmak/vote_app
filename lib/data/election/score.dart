class Score {
  final int id;
  final int score;
  final int partyId;

  Score({this.id, this.score, this.partyId});

  Score.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] == null ? 1 : parsedJson['id'],
        score = parsedJson['score'],
        partyId = parsedJson['party_id'];
}
