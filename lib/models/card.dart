class FlashCardModel {
  String id;
  String? question;
  String? answer;
  String? uid;
  String collectionId;
  String? description;

  FlashCardModel({
    this.question,
    required this.id,
    this.answer,
    this.uid,
    required this.collectionId,
    this.description,
  });
}
