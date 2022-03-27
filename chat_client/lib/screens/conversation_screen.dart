import 'package:chat_client/global.dart';
import 'package:chat_client/models/message_model.dart';
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
  User? toUser;

  @override
  void initState() {
    Global.socket!.receiveMessageListener(onReceiveHandler);
    super.initState();
  }

  List<MessageModel> messageList = [];
  addToMessageList(MessageModel msg) {
    setState(() {
      messageList.add(msg);
    });
  }

  onReceiveHandler(data) {
    final receivedMesage = MessageModel.fromJson(data);
    addToMessageList(receivedMesage);
  }

  @override
  Widget build(BuildContext context) {
    toUser = ModalRoute.of(context)!.settings.arguments as User?;
    final TextEditingController _messageController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(toUser == null ? 'null' : toUser!.name!),
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemBuilder: ((context, index) => ListTile(
                title: Text(
                  messageList[index].message!,
                  style: TextStyle(color: Colors.white),
                ),
              )),
          itemCount: messageList.length,
        )),
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
          onPressed: () {
            final Map<String, dynamic> sendingMsg = MessageModel.toJson(
                MessageModel(
                    from: Global.currentUser!.id,
                    to: toUser!.id!,
                    message: controller.text));
            Global.socket!.sendMessageHandler(sendingMsg);
            addToMessageList(MessageModel(
                from: Global.currentUser!.id,
                to: toUser!.id!,
                message: controller.text));
          },
          icon: const Icon(
            Icons.send,
            color: Colors.teal,
          ),
        )
      ],
    );
  }
}
