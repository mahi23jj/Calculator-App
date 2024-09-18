import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Name {
  String Title='';
  String subtitle='';
  Name({required this.Title,required this.subtitle});
}
class calculator  extends ChangeNotifier {
  List<Name> history = [];
  get historyList => history;

  void addHistory(Name value) {
    history.add(value);
    notifyListeners();
  }
}
