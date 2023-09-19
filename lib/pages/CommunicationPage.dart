


import 'package:atom_app/IPAddresProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunicationPage extends StatefulWidget {
  final String socket;
  final int port;
  const CommunicationPage({super.key, required, required this.socket, required this.port });
  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  

  @override
  Widget build(BuildContext context,) {
    final sharedData = Provider.of<IpAddresProvider>(context);
    
    return Scaffold(

        body: Column(
          children: [
            const Text("Communication Page"),
            Text(sharedData.ipAddresProvider),
            // Text("IP Address: ${context.watch<IpAddresProvider>().IpAddres}"),
          ],
        ),
          
      
    );
  }
}