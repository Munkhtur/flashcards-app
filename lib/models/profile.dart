class ProfileModel {
  final String name;
  final int numOfCards;
  final int numOfMasterd;

  ProfileModel({
    required this.name,
    required this.numOfCards,
    required this.numOfMasterd,
  });

  ProfileModel.fromMap(Map<String, dynamic>? data)
      : name = data?["name"],
        numOfCards = data?["numOfCards"],
        numOfMasterd = data?["numOfMastered"];
}
