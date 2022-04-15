import 'package:chat_client/global.dart';
import 'package:chat_client/razorpay_key.dart';
import 'package:chat_client/screens/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChatUsersScreen extends StatefulWidget {
  static const routeName = '/chat-users-screen';
  const ChatUsersScreen({Key? key}) : super(key: key);

  @override
  _ChatUsersScreenState createState() => _ChatUsersScreenState();
}

class _ChatUsersScreenState extends State<ChatUsersScreen> {
  final Razorpay _razorpay = Razorpay();

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
    // ignore:avoid_print
    print('Connected');
  }

  onConnectError(data) {
    // ignore:avoid_print
    print('onConnect Error : $data');
  }

  onConnectTimeout(data) {
    // ignore:avoid_print
    print('onConnect timeout: $data');
  }

  onDisconnect(data) {
    // ignore:avoid_print
    print('Disconnected');
  }

  @override
  void dispose() {
    Global.socket!.closeConnection();
    _razorpay.clear();
    super.dispose();
  }

  @override
  void initState() {
    initSocket();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccessHandler);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentErrorHandler);

    super.didChangeDependencies();
  }

  _paymentSuccessHandler(PaymentSuccessResponse success) {
    // ignore:avoid_print
    print('Payment Success : $success');
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: const [
        SizedBox(width: 50),
        Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.black,
        ),
        SizedBox(width: 50),
        Expanded(child: Text('Hooray!! You\'re subscribed!!'))
      ]),
      backgroundColor: Colors.green[100],
    ));
  }

  _paymentErrorHandler(PaymentFailureResponse failure) {
    // ignore:avoid_print
    print('Payment Failure: $failure');

    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      content: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: const ListTile(
            leading: Icon(
              Icons.close_rounded,
              color: Colors.black,
            ),
            title: Text('Oops!! Error processing payment.')),
      ),
      backgroundColor: Colors.red[100],
    ));
  }

  Map<String, dynamic> options = {
    'key': RazorPayCreds.testKey, // <YOUR_RAZORPAY_KEY>
    'amount': 100,
    'name': 'ChatMessaging',
    'description': 'Subscription to Chat',
    'prefill': {'contact': '9952632252', 'email': 'test@razorpay.com'},
  };

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
      floatingActionButton: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 6)),
              backgroundColor: MaterialStateProperty.all(Colors.teal)),
          onPressed: () async {
            try {
              _razorpay.open(options);
            } catch (e) {
              // ignore:avoid_print
              print('Error : ${e.toString()}');
            }
          },
          child: const Text(
            'Subscribe to Chat Feature',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
