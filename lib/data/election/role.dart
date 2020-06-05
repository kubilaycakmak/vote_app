class Role {
  final int id;
  final String name;

  Role({this.id, this.name});

  Role.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] == null ? 1 : parsedJson['id'],
        name = parsedJson['name'];
}
