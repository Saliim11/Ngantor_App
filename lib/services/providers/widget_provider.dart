import 'package:flutter/widgets.dart';

class WidgetProvider with ChangeNotifier{
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  void changeVisibility(){
    _isVisible = !_isVisible;
    notifyListeners();
  }
  
}