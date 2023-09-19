import 'package:atom_app/IPAddresProvider.dart';
import 'package:atom_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => IpAddresProvider(),
      child: MyApp(),
    ),
  );
}






class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
    return MaterialApp(
      title: 'ATOM',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
