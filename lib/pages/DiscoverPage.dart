import 'package:atom_app/widgets/DiscoverWidget.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bnbthird.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const DiscoverWidget(),
      ),
    );
  }
}
