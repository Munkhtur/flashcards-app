class ProfileModel {
  final String name;
  final int numOfDecks;
  final int numOfCards;
  final int numOfMasterd;

  ProfileModel({
    required this.name,
    required this.numOfCards,
    required this.numOfDecks,
    required this.numOfMasterd,
  });

  ProfileModel.fromMap(Map<String, dynamic> data)
      : name = data["name"],
        numOfCards = data["numOfCards"],
        numOfDecks = data["numOfDecks"],
        numOfMasterd = data["numOfMastered"];
}
