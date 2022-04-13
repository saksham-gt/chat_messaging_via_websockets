import 'package:chat_client/screens/chat_users_screen.dart';
import 'package:chat_client/screens/conversation_screen.dart';
import 'package:chat_client/screens/login_screen.dart';
import 'package:chat_client/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      routes: {
        '/login-screen': (ctx) => LoginScreen(),
        '/chat-users-screen': (ctx) => const ChatUsersScreen(),
        '/conversation-screen': (ctx) => const ConversationScreen(),
        '/user-profile-screen': (ctx) => const UserProfileScreen(),
      },
      initialRoute: '/login-screen',
    );
  }
}
