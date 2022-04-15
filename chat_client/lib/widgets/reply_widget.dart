import 'package:chat_client/models/message_model.dart';
import 'package:flutter/material.dart';

class ReplyMessageWidget extends StatelessWidget {
  final MessageModel msg;
  final VoidCallback? onCancelReply;
  final String? fromName;
  const ReplyMessageWidget({
    Key? key,
    required this.msg,
    required this.fromName,
    this.onCancelReply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(color: Colors.green, width: 4),
            const SizedBox(width: 10),
            buildReplyMessage()
          ],
        ),
      ),
    );
  }

  buildReplyMessage() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  fromName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                ),
                onPressed: () => onCancelReply!(),
              ),
            ],
          ),
          Text(
            msg.message!,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
