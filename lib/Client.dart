import 'dart:io';

class AtomClient {
  final String host;
  final int port;
  String serverResponse = '';
  Socket? _socket;
  bool _connected = false;

  AtomClient({required this.host, required this.port});



  
  Future<void> connect(Function? messageFnc) async {
    try {
      _socket = await Socket.connect(host, port);
      _connected = true;
      print('Connected to the server');
      _setupListeners(messageFnc);
    } catch (e) {
      print('Error: $e');
    }
  }
//create a function with lamda that will be called when a message is recived
  void _setupListeners(Function? messageFnc) {
    _socket!.listen(
      (data) {
        serverResponse = String.fromCharCodes(data);
        print('Received from server: $serverResponse');
        if (messageFnc != null) {
          messageFnc(serverResponse);
        }
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
