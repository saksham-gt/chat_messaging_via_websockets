import 'package:chat_client/global.dart';
import 'package:chat_client/screens/conversation_screen.dart';
import 'package:flutter/material.dart';

class ChatUsersScreen extends StatefulWidget {
  static const routeName = '/chat-users-screen';
  const ChatUsersScreen({Key? key}) : super(key: key);

  @override
  _ChatUsersScreenState createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  initSocket() async {
    Global.initSocket();
    await Global.socket!.initSocket(Global.currentUser!);
    Global.socket!.connectSocket();
    Global.socket!.setOnConnectListener(onConnectListener);
    Global.socket!.setOnConnectError(onConnectError);
    Global.socket!.setOnConnectTimeout(onConnectTimeout);
    Global.socket!.setOnDisconnect(onDisconnect);
  }

  onConnectListener(data) {
    print('Connected');
  }

  onConnectError(data) {
    print('onConnect Error : $data');
  }

  onConnectTimeout(data) {
    print('onConnect timeout: $data');
  }

  onDisconnect(data) {
    print('Disconnected');
  }

  @override
  void dispose() {
    Global.socket!.closeConnection();
    super.dispose();
  }

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            tileColor: Colors.blueGrey,
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(Global.dummyChatUsers![index].dpUrl!),
            ),
            title: Text(
              Global.dummyChatUsers![index].name!,
            ),
            onTap: () => Navigator.of(context).pushNamed(
                ConversationScreen.routeName,
                arguments: Global.dummyChatUsers![index]),
          ),
        ),
        itemCount: Global.dummyChatUsers!.length,
      ),
    );
  }
}
