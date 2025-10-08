import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  String? _selectedRole;

  String? get selectedRole => _selectedRole;
  

  void setRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}
