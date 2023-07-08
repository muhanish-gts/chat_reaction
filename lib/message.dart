enum Reaction { favorite, thumbsDown }

class Message {
  final String id;
  final String content;
  bool isSelected;
  Reaction? reaction;

  Message(
      {required this.id,
      required this.content,
      this.isSelected = false,
      this.reaction});
}
