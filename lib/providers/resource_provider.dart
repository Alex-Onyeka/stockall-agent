import 'package:flutter/material.dart';

class ResourceProvider extends ChangeNotifier {
  bool hideMoneyDashBoard = false;
  void toggleHideMoney() {
    hideMoneyDashBoard = !hideMoneyDashBoard;
    notifyListeners();
  }

  bool isLoading = false;

  void toggleLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
