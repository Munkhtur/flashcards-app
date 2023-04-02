class DeckModel {
  final String name;
  final String uid;
  final String id;

  DeckModel({required this.name, required this.id, required this.uid});

  DeckModel.fromMap(Map<String, dynamic> data)
      : name = data["name"],
        id = data['id'],
        uid = data["uid"];
}
