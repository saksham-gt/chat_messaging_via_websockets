class MessageModel {
  String? from;
  String? to;
  String? message;

  MessageModel({
    this.from,
    this.message,
    this.to,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        from: json['from'],
        message: json['message'],
        to: json['to'],
      );

  Map<String, dynamic> toJson(MessageModel msg) => {
        'to': msg.to,
        'from': msg.from,
        'message': msg.message,
      };
}
