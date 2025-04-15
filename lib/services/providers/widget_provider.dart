import 'package:flutter/widgets.dart';

class WidgetProvider with ChangeNotifier {
  int? _expandedField = -1;
  
  int get expandedField => _expandedField ?? -1;
  
  void toggleExpand(int index) {
      _expandedField = _expandedField == index ? null : index;
      notifyListeners();
  }

  bool _isFilledUsername = false;
  bool _isFilledEmail = false;
  bool _isFilledPassword = false;

  bool get isFilledUsername => _isFilledUsername;
  bool get isFilledEmail => _isFilledEmail;
  bool get isFilledPassword => _isFilledPassword;

  void setFilledStatus({required int index, required bool value}) {
    switch (index) {
      case 0:
        _isFilledUsername = value;
        break;
      case 1:
        _isFilledEmail = value;
        break;
      case 2:
        _isFilledPassword = value;
        break;
    }
    notifyListeners();
  }
}