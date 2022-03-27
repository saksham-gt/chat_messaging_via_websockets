import 'package:chat_client/socket_utils.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'models/user_model.dart';

class Global {
  static User? currentUser;
  static List<User>? dummyChatUsers;
  static SocketUtils? socket;
  static List<User> dummyUsers = [
    User(
      dpUrl: 'https://picsum.photos/id/237/200/300',
      id: '1',
      name: 'Ashwin',
    ),
    User(
      dpUrl: 'https://picsum.photos/id/238/200/300',
      id: '2',
      name: 'Shourya',
    ),
    User(
      dpUrl: 'https://picsum.photos/id/239/200/300',
      id: '3',
      name: 'Ayush',
    ),
    User(
      dpUrl: 'https://picsum.photos/id/240/200/300',
      id: '4',
      name: 'Kunal',
    ),
    User(
      dpUrl: 'https://picsum.photos/id/241/200/300',
      id: '5',
      name: 'Piyush',
    ),
    User(
      dpUrl: 'https://picsum.photos/id/242/200/300',
      id: '6',
      name: 'Saksham',
    )
  ];

  static set setCurrentUser(User user) {
    currentUser = user;
  }

  static set setDummyChatUsers(User user) {
    dummyChatUsers = [];
    dummyChatUsers!.addAll(dummyUsers);
    dummyChatUsers!.removeWhere((iuser) => user == iuser);
    print('Dummy chat users: ${dummyChatUsers!.length}');
  }

  static initSocket() {
    socket ??= SocketUtils();
  }
}
