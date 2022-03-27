import 'package:socket_io/socket_io.dart';

void main() {
  final server = Server();
  final nsp = server.of('/');
  server.listen(3000);

  Map userSocketMap = Map();
  String? from_user_id;

  onUserConnect(String? user_id, Socket socket) {
    userSocketMap.addAll({
      from_user_id: {'socket_id': socket.id}
    });
    print('SOCKET ID for $from_user_id: ${socket.id}');
  }

  String getSocketOfRecepient(String? recepientId) {
    return userSocketMap[recepientId]['socket_id'];
  }

  onSendMessage(Socket socket) {
    socket.on('send-message', (data) {
      final recepientSID = getSocketOfRecepient(data['to']);
      socket.to(recepientSID).emit('receive-message', data);
    });
  }

  nsp.on('connection', (socket) {
    final _socket = socket as Socket;
    from_user_id = socket.handshake!['query']['from'];
    onUserConnect(from_user_id, _socket);

    onSendMessage(_socket);
  });
}
