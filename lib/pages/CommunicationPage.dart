import 'package:atom_app/Client.dart';
import 'package:atom_app/IPAddresProvider.dart';
import 'package:atom_app/Package.dart';
import 'package:atom_app/color.dart';
import 'package:atom_app/widgets/GuageWidget.dart';
import 'package:atom_app/widgets/JoyStickWidger..dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter_joystick/flutter_joystick.dart';

class CommunicationPage extends StatefulWidget {
  const CommunicationPage({super.key, required});
  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  int _SelectedTab = 0;
  int GetSlectefTab() => _SelectedTab;
  final String _ButtonState = "Connect";
  String? socket = "";
  final int port = 12345;

  AtomClient? client;
  List<SensorData> _SensorData = <SensorData>[];

  int slectedButtonIndex = 0;
  String actionState = "";
  @override
  Widget build(
    BuildContext context,
  ) {
    final sharedData = Provider.of<IpAddresProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bnbmain.png'),
            fit: BoxFit.cover,
          ),
        ),
        // child: Text(sharedData.ipAddresProvider),

        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("ATOM",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: col_grey)),
                      if (sharedData.ipAddresProvider.isNotEmpty)
                        Text("Selected IP: ${sharedData.ipAddresProvider} 🔗",
                            style:
                                const TextStyle(fontSize: 15, color: col_grey))
                      else
                        Text("Please open Discover Tab 🔍 , ${actionState}",
                            style: TextStyle(fontSize: 15, color: col_grey)),
                    ],
                  ),
                  FancyButton(
                      button_text: _ButtonState,
                      button_height: 40,
                      button_width: 100,
                      button_radius: 10,
                      button_color: const Color.fromARGB(100, 189, 189, 189),
                      button_outline_color: col_grey,
                      button_outline_width: 1,
                      button_text_color: col_grey,
                      button_icon_color: col_grey,
                      icon_size: 22,
                      button_text_size: 15,
                      onClick: () {
                        actionState = "";
                        print("Button clicked");
                        socket = sharedData.ipAddresProvider;
                        client = AtomClient(host: socket!, port: port);
                        client!.connect(onMessageRecived);
                      })
                ],
              ),

              const SizedBox(height: 8),

              CupertinoTabBar.CupertinoTabBar(
                const Color.fromARGB(100, 189, 189, 189),
                const Color.fromARGB(150, 189, 189, 189),
                // outerVerticalPadding: 40,
                // outerHorizontalPadding: 40,
                innerHorizontalPadding: 25,
                // innerVerticalPadding: 40,

                const [
                  Text(
                    "       Sensor         ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "       Controll       ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.75,
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProRounded",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                GetSlectefTab,
                (int index) {
                  setState(() {
                    _SelectedTab = index;
                  });
                },
                useSeparators: true,
              ),

              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(right: 35, left: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FancyButton(
                        button_text: "Start",
                        button_height: 40,
                        button_width: 100,
                        button_radius: 10,
                        button_color: const Color.fromARGB(100, 189, 189, 189),
                        button_outline_color: col_grey,
                        button_outline_width: 1,
                        button_text_color: col_grey,
                        button_icon_color: col_grey,
                        icon_size: 22,
                        button_text_size: 15,
                        onClick: () {
                          print("Button clicked");
                          setState(() {
                            actionState = "Starting";
                            slectedButtonIndex = 1;
                          });
                          client!.sendMessage("?start?");
                        }),
                    FancyButton(
                        button_text: "Stop",
                        button_height: 40,
                        button_width: 100,
                        button_radius: 10,
                        button_color: const Color.fromARGB(100, 189, 189, 189),
                        button_outline_color: col_grey,
                        button_outline_width: 1,
                        button_text_color: col_grey,
                        button_icon_color: col_grey,
                        icon_size: 22,
                        button_text_size: 15,
                        onClick: () {
                          print("Button clicked");
                          setState(() {
                            slectedButtonIndex = 2;
                            actionState = "Stoping";
                          });
                          client!.sendMessage("?stop?");
                        }),
                    FancyButton(
                        button_text: "Park",
                        button_height: 40,
                        button_width: 100,
                        button_radius: 10,
                        button_color: const Color.fromARGB(100, 189, 189, 189),
                        button_outline_color: col_grey,
                        button_outline_width: 1,
                        button_text_color: col_grey,
                        button_icon_color: col_grey,
                        icon_size: 22,
                        button_text_size: 15,
                        onClick: () {
                          print("Park clicked");
                          setState(() {
                            slectedButtonIndex = 3;
                            actionState = "Parking";
                          });
                          client!.sendMessage("?park?");
                        })
                  ],
                ),
              ),
              const SizedBox(height: 8),

              //Switch between Sensor and Controll widgets when is control is a emty container
              if (_SelectedTab == 0)
                Expanded(
                    child: GridView.builder(
                        itemCount: _SensorData.length,
                        padding: const EdgeInsets.all(5),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1 / 1.4, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return GuageWidget(
                            name: _SensorData[index].name,
                            value: _SensorData[index].value.toInt(),
                            type: index,
                          );
                        }))
              else
                Expanded(
                  child: Container(child: JoystickExample(
                    onChangeCallback: (x, y) {
                      print("x: $x, y: $y");
                      client!.sendMessage(
                          "?${x.toStringAsFixed(2)}:${y.toStringAsFixed(2)}?");
                    },
                  )),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void onMessageRecived(String message) {
    print("Messsage fom comunication widget" + message);

    //parse message using the package class and example "1:Temperature:25"
    //int id , String name , double value

    List<String> _message = message.split(":");
    // _SensorData.add(SensorData(id: int.parse(_message[0]), name: _message[1], value: double.parse(_message[2])));
    //Add onli if the id is not in the list if exist update value

    setState(() {
      if (_SensorData.where((element) => element.id == int.parse(_message[0]))
          .isEmpty) {
        _SensorData.add(SensorData(
            id: int.parse(_message[0]),
            name: _message[1],
            value: double.parse(_message[2])));
      } else {
        _SensorData[_SensorData.indexWhere(
                (element) => element.id == int.parse(_message[0]))]
            .value = double.parse(_message[2]);
      }
    });
  }
}
