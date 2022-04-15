import 'package:chat_client/global.dart';
import 'package:chat_client/models/message_model.dart';
import 'package:chat_client/screens/user_profile_screen.dart';
import 'package:chat_client/widgets/message_widget.dart';
import 'package:chat_client/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import '../models/user_model.dart';

class ConversationScreen extends StatefulWidget {
  static const routeName = '/conversation-screen';

  const ConversationScreen({Key? key}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  User? toUser;
  final focusNode = FocusNode();
  MessageModel? replyMessage;

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
    print('Received Data: $data');
    if (receivedMesage.from == toUser!.id) {
      addToMessageList(receivedMesage);
    }
  }

  replyToMessage(MessageModel msg) {
    setState(() {
      replyMessage = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    toUser = ModalRoute.of(context)!.settings.arguments as User?;
    final TextEditingController _messageController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: GestureDetector(
          child: Text(toUser == null ? 'null' : toUser!.name!),
          onTap: () => Navigator.pushNamed(
            context,
            UserProfileScreen.routeName,
            arguments: toUser,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) => Row(children: [
                    if (messageList[index].from == Global.currentUser!.id)
                      Expanded(child: Container()),
                    SwipeTo(
                        onRightSwipe: () {
                          replyToMessage(messageList[index]);
                          print('isFocusNode null: ${focusNode == null}');
                          focusNode.requestFocus();
                        },
                        child: MessageWidget(
                          index: index,
                          messageList: messageList,
                        )),
                    if (messageList[index].from != Global.currentUser!.id)
                      Expanded(child: Container()),
                  ])),
              itemCount: messageList.length,
            ),
          ),
          inputMessage(_messageController)
        ]),
      ),
    );
  }

  inputMessage(TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8, bottom: 6),
            child: TextInputWidget(
              focusNode: focusNode,
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
