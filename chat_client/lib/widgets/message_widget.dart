import 'package:chat_client/global.dart';
import 'package:chat_client/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final List<MessageModel>? messageList;
  final int? index;
  const MessageWidget({
    Key? key,
    this.index,
    this.messageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(5),
            topRight: const Radius.circular(5),
            bottomLeft: messageList![index!].from == Global.currentUser!.id
                ? const Radius.circular(5)
                : Radius.zero,
            bottomRight: messageList![index!].from == Global.currentUser!.id
                ? Radius.zero
                : const Radius.circular(5)),
        color: messageList![index!].from == Global.currentUser!.id
            ? Colors.pink[200]
            : Colors.blueGrey[100],
      ),
      margin: EdgeInsets.only(
          left: messageList![index!].from == Global.currentUser!.id ? 0 : 8,
          right: messageList![index!].from == Global.currentUser!.id ? 8 : 0,
          top: 6,
          bottom: 6),
      width: MediaQuery.of(context).size.width * 0.75,
      child: messageList![index!].replyMsg != null
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                        color:
                            messageList![index!].from != Global.currentUser!.id
                                ? Colors.blueGrey
                                : Colors.green[200],
                        width: 4),
                    const SizedBox(width: 10),
                    ReplyMessageShow(
                        replyMessage: messageList![index!].replyMsg,
                        replyUserName: messageList![index!].replyMsgUserName),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                messageList![index!].message!,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ])
          : Text(
              messageList![index!].message!,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
    );
  }
}

class ReplyMessageShow extends StatelessWidget {
  final String? replyMessage;
  final String? replyUserName;
  const ReplyMessageShow({
    Key? key,
    this.replyMessage,
    this.replyUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              replyUserName!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Text(
            replyMessage!,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
