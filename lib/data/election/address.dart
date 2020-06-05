class Address {
  final int id;
  final String neighborhood;
  final String city;

  Address({this.id, this.neighborhood, this.city});

  Address.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] == null ? 1 : parsedJson['id'],
        neighborhood = parsedJson['neighborhood'],
        city = parsedJson['city'];
}
