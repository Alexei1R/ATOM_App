import 'dart:io';

class Cient {
  final String host;
  final int port;
  Socket? _socket;
  bool _connected = false;

  Cient({required this.host, required this.port});

  Future<void> connect() async {
    try {
      _socket = await Socket.connect(host, port);
      _connected = true;
      print('Connected to the server');
      _setupListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  void _setupListeners() {
    _socket!.listen(
      (data) {
        final serverResponse = String.fromCharCodes(data);
        print('Received from server: $serverResponse');
      },
      onError: (error) {
        print('Error: $error');
      },
      onDone: () {
        print('Server connection closed');
        _connected = false;
        _socket?.destroy();
      },
    );
  }

  void sendMessage(String message) {
    if (_connected) {
      _socket!.write(message);
    } else {
      print('Not connected to the server');
    }
  }

  void disconnect() {
    if (_connected) {
      _socket!.close();
      _connected = false;
      print('Disconnected from the server');
    } else {
      print('Not connected to the server');
    }
  }
}
