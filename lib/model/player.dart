class Player {
  final int id;
  final String name;

  Player({required this.id, required this.name});

  factory Player.fromSqfliteDatabase(Map<String, dynamic> map) =>
      Player(id: map['id']?.toInt() ?? 0, name: map['name'] ?? '');
}
