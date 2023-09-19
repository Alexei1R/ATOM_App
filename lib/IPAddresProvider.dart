
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';





class IpAddresProvider extends ChangeNotifier {
  String _ipAddresProvider = '';

  String get ipAddresProvider => _ipAddresProvider;

  void updateIpAddres({required String newValue}) {
    _ipAddresProvider = newValue;
    notifyListeners();
  }
}