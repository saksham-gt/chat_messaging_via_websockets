// import 'package:chat_client/models/user_model.dart';
// import 'package:chat_client/widgets/text_input.dart';
// import 'package:flutter/material.dart';

// import '../global.dart';
// import '../models/message_model.dart';

// class InputMessage extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final Function onSendCallback;
//   final User toUser;
//   const InputMessage({
//     Key? key,
//     required this.onSendCallback,
//     required this.toUser,
//     required this.focusNode,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(left: 8, bottom: 6),
//           child: TextInputWidget(
//             controller: controller,
//             hintText: 'Enter message',
//           ),
//         ),
//         const SizedBox(width: 5),
//         IconButton(
//           onPressed: () {
//             final Map<String, dynamic> sendingMsg = MessageModel.toJson(
//                 MessageModel(
//                     from: Global.currentUser!.id,
//                     to: toUser.id!,
//                     message: controller.text));
//             Global.socket!.sendMessageHandler(sendingMsg);
//             onSendCallback(MessageModel(
//                 from: Global.currentUser!.id,
//                 to: toUser.id!,
//                 message: controller.text));
//           },
//           icon: const Icon(
//             Icons.send,
//             color: Colors.teal,
//           ),
//         )
//       ],
//     );
//   }
// }
