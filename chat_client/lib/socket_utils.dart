import 'package:chat_client/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'models/user_model.dart';

class SocketUtils {
  static Socket? socket;
  static User? fromUser;
  static String baseUrl = 'http://localhost';
  static String port = '3000';

  static String ON_CONNECTION = 'connection';
  static String ON_DISCONNECT = 'disconnect';
  static String ON_SEND_MESSAGE = 'send-message';
  static String ON_RECEIVE_MESSAGE = 'receive-message';

  static String connectUrl = '$baseUrl:$port';

  initSocket(User user) async {
    fromUser = user;
    await _init();
  }

  _init() {
    socket = io(
        connectUrl,
        OptionBuilder().setTransports(['websocket']).setQuery(
            {'from': fromUser!.id!}).build());
  }

  connectSocket() {
    socket!.connect();
  }

  receiveMessageListener(Function receiveMessageHandler) {
    socket!.on(ON_RECEIVE_MESSAGE, (data) => receiveMessageHandler(data));
  }

  sendMessageHandler(Map<String, dynamic> data) {
    socket!.emit(ON_SEND_MESSAGE, data);
    print(data);
  }

  setOnConnectListener(Function onConnectListener) {
    socket!.onConnect((data) => onConnectListener(data));
  }

  setOnConnectError(Function onConnectError) {
    socket!.onConnectError((data) => onConnectError(data));
  }

  setOnConnectTimeout(Function onConnectTimeout) {
    socket!.onConnectTimeout((data) => onConnectTimeout(data));
  }

  setOnDisconnect(Function onDisconnect) {
    socket!.onDisconnect((data) => onDisconnect(data));
  }

  closeConnection() {
    socket!.disconnect();
    socket!.clearListeners();
  }
}
