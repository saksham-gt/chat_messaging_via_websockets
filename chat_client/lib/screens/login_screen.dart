import 'package:chat_client/global.dart';
import 'package:chat_client/models/user_model.dart';
import 'package:chat_client/screens/chat_users_screen.dart';
import 'package:chat_client/widgets/text_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _loginController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Chat Login'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInputWidget(
            controller: _loginController,
            hintText: 'Enter login name',
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              final currUser = Global.dummyUsers.firstWhere(
                  (user) => user.name == _loginController.text,
                  orElse: () => User(id: '-1'));
              if (currUser.id != '-1') {
                Global.currentUser = currUser;
                Global.setDummyChatUsers = currUser;
                Navigator.pushNamed(context, ChatUsersScreen.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No user found!!')));
              }
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(80, 40)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.teal)),
          )
        ],
      ),
    );
  }
}
