import 'package:flutter/cupertino.dart';

class UsuarioState with ChangeNotifier {
  List<int> selectedItems = [];

  void toggleSelection(int id) {
    if (selectedItems.contains(id)) {
      selectedItems.remove(id);
    } else {
      selectedItems.add(id);
    }
    notifyListeners();
  }
}