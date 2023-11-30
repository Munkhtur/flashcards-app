class DeckModel {
  final String name;
  final String uid;
  final String id;
  final double progress;

  DeckModel({
    required this.name,
    required this.id,
    required this.uid,
    required double progress,
  }) : progress = progress.toDouble();

  DeckModel.fromMap(Map<String, dynamic> data)
      : name = data["name"],
        id = data['id'],
        uid = data["uid"],
        progress = (data["progress"] ?? 0).toDouble();
}
