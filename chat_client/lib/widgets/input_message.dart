import 'package:chat_client/widgets/reply_widget.dart';
import 'package:chat_client/widgets/text_input.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class InputMessage extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final User toUser;
  final Function onSendCallback;
  final MessageModel? replyMessage;
  final VoidCallback onCancelReply;

  const InputMessage({
    required this.onCancelReply,
    required this.replyMessage,
    required this.onSendCallback,
    required this.focusNode,
    required this.controller,
    required this.toUser,
    Key? key,
  }) : super(key: key);

  @override
  _InputMessageState createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  @override
  Widget build(BuildContext context) {
    final isReplying = widget.replyMessage != null;
    return Row(children: [
      Expanded(
        child: Column(
          children: [
            if (isReplying) buildReply(),
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 6),
              child: TextInputWidget(
                focusNode: widget.focusNode,
                controller: widget.controller,
                hintText: 'Enter message',
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 5),
      IconButton(
        onPressed: () {
          widget.onCancelReply();
          final Map<String, dynamic> sendingMsg = MessageModel.toJson(
              MessageModel(
                  from: Global.currentUser!.id,
                  to: widget.toUser.id!,
                  message: widget.controller.text));
          Global.socket!.sendMessageHandler(sendingMsg);
          widget.onSendCallback(MessageModel(
              from: Global.currentUser!.id,
              to: widget.toUser.id!,
              message: widget.controller.text));
        },
        icon: const Icon(
          Icons.send,
          color: Colors.teal,
        ),
      ),
    ]);
  }

  buildReply() {
    return Container(
      margin: const EdgeInsets.only(left: 8, bottom: 2),
      decoration: BoxDecoration(
          color: Colors.pinkAccent[100]!.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          )),
      child: ReplyMessageWidget(
          msg: widget.replyMessage!,
          onCancelReply: widget.onCancelReply,
          fromName: widget.toUser.name),
    );
  }
}
