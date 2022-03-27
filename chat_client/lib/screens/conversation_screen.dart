import 'package:chat_client/widgets/text_input.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ConversationScreen extends StatefulWidget {
  static const routeName = '/conversation-screen';

  const ConversationScreen({Key? key}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    final toUser = ModalRoute.of(context)!.settings.arguments as User?;
    final TextEditingController _messageController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(toUser == null ? 'null' : toUser.name!),
      ),
      body: Column(children: [
        Expanded(child: Container()),
        inputMessage(_messageController)
      ]),
    );
  }

  inputMessage(TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8, bottom: 6),
            child: TextInputWidget(
              controller: controller,
              hintText: 'Enter message',
            ),
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.send,
            color: Colors.teal,
          ),
        )
      ],
    );
  }
}
