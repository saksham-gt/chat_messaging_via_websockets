class MessageModel {
  String? from;
  String? to;
  String? message;
  String? replyMsg;
  String?
      replyMsgUserName; // The username of the client whose msg is swiped to reply

  MessageModel({
    this.from,
    this.message,
    this.to,
    this.replyMsg,
    this.replyMsgUserName,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        from: json['from'],
        message: json['message'],
        to: json['to'],
        replyMsg: json['replyMsg'],
        replyMsgUserName: json['replyMsgUserName'],
      );

  static Map<String, dynamic> toJson(MessageModel msg) => {
        'to': msg.to,
        'from': msg.from,
        'message': msg.message,
        'replyMsg': msg.replyMsg,
        'replyMsgUserName': msg.replyMsgUserName,
      };
}
