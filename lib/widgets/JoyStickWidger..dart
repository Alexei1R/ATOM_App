// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';


 double _x = 100;
  double _y = 100;

typedef JoystickChangeCallback = void Function(double x, double y);






class JoystickExample extends StatefulWidget {

final JoystickChangeCallback? onChangeCallback; 

  const JoystickExample({Key? key, this.onChangeCallback}) : super(key: key);

  @override
  _JoystickExampleState createState() => _JoystickExampleState();
}

class _JoystickExampleState extends State<JoystickExample> {
 
  final JoystickMode _joystickMode = JoystickMode.all;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(0, 0, 0, 0),
            ),
            
            Align(
              alignment: const Alignment(0, 0.8),
              child: Joystick(
                stick: const JoystickStick(),
                mode: _joystickMode,
                listener: (details) {
                  setState(() {
                    _x =  details.x;
                    _y =  details.y;
                    // print("x: $_x, y: $_y");
                    widget.onChangeCallback!(_x, _y);
                    
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  


  
}










class JoystickStick extends StatelessWidget {
  const JoystickStick({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 46, 49, 51).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(43, 45, 46, 1),
            Color.fromRGBO(41, 43, 44, 1),
          ],
        ),
      ),
    );
  }
}
