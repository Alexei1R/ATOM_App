import 'package:atom_app/color.dart';
import 'package:atom_app/pages/DiscoverPage.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import 'pages/CommunicationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  //list of widgets
  final List<Widget> _widgetOptions = <Widget>[
    const DiscoverScreen(),
    const CommunicationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          color: col_bg,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: GNav(
                gap: 8,
                padding:
                const EdgeInsets.symmetric(horizontal: 70, vertical: 8),
                iconSize: 14,
                duration: const Duration(milliseconds: 400),
                backgroundColor: col_bg,
                color: col_grey,
                activeColor: col_grey,
                tabs: const [
                  GButton(
                    icon: Icons.control_camera,
                    // text: 'Control',
                  ),
                  GButton(
                    icon: Icons.connect_without_contact,
                    // text: 'Connect',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
