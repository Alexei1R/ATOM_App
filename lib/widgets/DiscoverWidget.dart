// ignore_for_file: depend_on_referenced_packages

import 'package:atom_app/color.dart';
import 'package:flutter/material.dart';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:atom_app/IPAddresProvider.dart';
import 'package:provider/provider.dart';


class DiscoverWidget extends StatefulWidget {
  const DiscoverWidget({super.key});

  @override
  State<DiscoverWidget> createState() => _DiscoverWidgetState();
}

class _DiscoverWidgetState extends State<DiscoverWidget> {
  String _ButtonState = "Scan";
  String _InfoState = "";
  final List<Host> _hosts = <Host>[];
  double? progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<IpAddresProvider>(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.09,
          left: MediaQuery.of(context).size.width * 0.14,
          right: 0,
          bottom: MediaQuery.of(context).size.height * 0.18),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        // color: const Color.fromARGB(75, 33, 149, 243),
        child: Padding(
          padding: const EdgeInsets.only(left :20.0 , right: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FancyButton(
                        button_text: _ButtonState,
                        button_height: 40,
                        button_width: 100,
                        button_radius: 10,
                        button_color: Color.fromRGBO(148, 175, 177, 0),
                        button_outline_color: Color.fromARGB(255, 36, 49, 49),
                        button_outline_width: 1,
                        button_text_color: col_bg,
                        button_icon_color: col_bg,
                        icon_size: 22,
                        button_text_size: 15,
                        onClick: () async {
                          print("Button clicked");
                          setState(() {
                            _ButtonState = "Scanning";
                            _InfoState = "";
                            progress = 0;
                            _hosts.clear();
                          });
                          final scanner = LanScanner(debugLogging: false);
                          final hosts = await scanner.quickIcmpScanAsync(
                            ipToCSubnet(await NetworkInfo().getWifiIP() ?? ''),
                          );
                          
                      
                          //parse ip address name and mac address
                          
                      
                      
                          setState(() {
                            _ButtonState = "Rescan";
                            _InfoState = "Found ${hosts.length} devices👌";
                            progress = 1.0;
                            _hosts.clear();
                            _hosts.addAll(hosts);
                          });
                          print("Scan complete");
                          // print all ip addresses
                          _hosts.forEach((host) => print(host.internetAddress));
                        }),
                        Text("🏎️" , style: TextStyle(fontSize: 40),)
                  ],
                ),
              ),
              
              if(_InfoState != "")Text(_InfoState,style : const TextStyle(color: Colors.white, fontSize: 20)),
              // cool list view witha card with a ai addres , name and a button to connect
              Expanded(
                child: ListView.builder(
                  itemCount: _hosts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      
                      color:const Color.fromARGB(0, 36, 49, 49),
                      child: ListTile(
                        //trim print only ip address
                        title: Text(_hosts[index].internetAddress.toString().substring(15), style: const TextStyle(color: Colors.white),),
                        // title: Text(_hosts[index].internetAddress.toString()),
                        
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(108, 255, 255, 255),
                            foregroundColor: Colors.white,
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            
                          ),
                          onPressed: () {
                          // Get the raw IP address as a string
                          String rawIpAddress = _hosts[index].internetAddress.toString();

                          // Use a regular expression to extract the IP address
                          RegExp regex = RegExp(r'(\d+\.\d+\.\d+\.\d+)');
                          Match? match = regex.firstMatch(rawIpAddress);

                          // Check if a match was found and extract the IP address
                          if (match != null) {
                            String ipAddress = match.group(0)!;
                            
                            // Trim any leading or trailing spaces
                            ipAddress = ipAddress.trim();
                            sharedData.updateIpAddres(newValue: ipAddress);
                            setState(() {
                              _InfoState = "You Selected: $ipAddress 👍";
                            });
                            
                          }
                        },
                          child: const Text("Select"),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  


}
