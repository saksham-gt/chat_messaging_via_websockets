import 'package:chat_client/screens/conversation_screen.dart';
import 'package:flutter/material.dart';

class ChatUsersScreen extends StatefulWidget {
  static const routeName = '/chat-users-screen';
  const ChatUsersScreen({Key? key}) : super(key: key);

  @override
  _ChatUsersScreenState createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Chats'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ConversationScreen.routeName);
            },
            icon: const Icon(
              Icons.abc,
              color: Colors.white,
            )),
      ),
    );
  }
}
