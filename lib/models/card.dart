class FlashCardModel {
  String id;
  String question;
  String answer;
  String uid;
  String collectionId;
  String description;

  FlashCardModel({
    required this.question,
    required this.id,
    required this.answer,
    required this.uid,
    required this.collectionId,
    required this.description,
  });
}
