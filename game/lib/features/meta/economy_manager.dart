import 'package:flutter/foundation.dart';

class EconomyManager extends ChangeNotifier {
  int _festivalCoins = 0;
  int _legendTokens = 0;

  int get festivalCoins => _festivalCoins;
  int get legendTokens => _legendTokens;

  void addCoins(int amount) {
    if (amount <= 0) return;
    _festivalCoins += amount;
    notifyListeners();
  }

  bool spendCoins(int amount) {
    if (amount <= 0) return false;
    if (_festivalCoins >= amount) {
      _festivalCoins -= amount;
      notifyListeners();
      return true;
    }
    return false;
  }

  void addTokens(int amount) {
    if (amount <= 0) return;
    _legendTokens += amount;
    notifyListeners();
  }
}
