class Message {
  final String text;
  final bool isUserMessage;

  Message(this.text, this.isUserMessage);

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUserMessage': isUserMessage,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['text'] as String,
      json['isUserMessage'] as bool,
    );
  }
}
