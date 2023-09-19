


import 'package:atom_app/IPAddresProvider.dart';
import 'package:atom_app/color.dart';
import 'package:atom_app/widgets/GuageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;


class CommunicationPage extends StatefulWidget {
  final String socket;
  final int port;
  const CommunicationPage({super.key, required, required this.socket, required this.port });
  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  int _SelectedTab = 1;
  int GetSlectefTab() => _SelectedTab;
  final String _ButtonState = "Connect";
  

  @override
  Widget build(BuildContext context,) {
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
                      const Column(
                        children: [
                          Text("ATOM",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: col_grey)),
                          Text("Sensor Center of the robot",
                              style: TextStyle(fontSize: 15, color: col_grey)),
                        ],
                      ),
                      
                      FancyButton(
                        button_text: _ButtonState,
                        button_height: 40,
                        button_width: 100,
                        button_radius: 10,
                        button_color:const Color.fromARGB(100, 189, 189, 189),
                        button_outline_color: col_grey,
                        button_outline_width: 1,
                        button_text_color: col_grey,
                        button_icon_color: col_grey,
                        icon_size: 22,
                        button_text_size: 15,
                        onClick: () {
                          print("Button clicked");
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
                

                //Switch between Sensor and Controll widgets when is control is a emty container
                if(_SelectedTab == 0) Expanded(
                  child: GridView.builder(
                    itemCount: 6,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 1.4, crossAxisCount: 2),
                     itemBuilder: (context,index){
                         
                          
                          return GuageWidget(name: 'name', value: index, type: index,);

                     }
                     
                     
                     
                     
                     
                     )
                )
                else const Expanded(child: Center(child: Text("Controll", style: TextStyle(color: Colors.white),))),






                
        
        
        
              ],
        
        
        
          ),
        ),


      ),
    );
  }
}