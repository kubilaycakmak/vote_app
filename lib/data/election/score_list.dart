import 'score.dart';

class ScoreList {
  final List<Score> scores;

  ScoreList({this.scores});

  factory ScoreList.fromJson(List<dynamic> parsedJson) {
    List<Score> scores = new List<Score>();

    scores = parsedJson.map((e) => Score.fromJson(e)).toList();

    return new ScoreList(
      scores: scores,
    );
  }
}
