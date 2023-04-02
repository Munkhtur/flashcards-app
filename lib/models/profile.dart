class ProfileModel {
  final String name;
  final int? numOfDecks;
  final int? numOfCards;
  final int? numOfMasterd;

  ProfileModel({
    required this.name,
    this.numOfCards,
    this.numOfDecks,
    this.numOfMasterd,
  });

  ProfileModel.fromMap(Map<String, dynamic> data)
      : name = data["name"],
        numOfCards = data["numOfCards"],
        numOfDecks = data["numOfDecks"],
        numOfMasterd = data["numOfMastered"];
}
