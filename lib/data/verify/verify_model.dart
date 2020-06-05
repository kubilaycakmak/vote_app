class Verify {
  final String name;

  Verify({this.name});

  Verify.fromJson(Map<String, dynamic> json) : name = json['name'];
}
