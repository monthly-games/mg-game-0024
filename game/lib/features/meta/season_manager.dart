import 'package:flutter/foundation.dart';
import 'economy_manager.dart';

class SeasonReward {
  final int level;
  final int coins;
  final int tokens;
  final String description;
  bool isClaimed;

  SeasonReward({
    required this.level,
    this.coins = 0,
    this.tokens = 0,
    required this.description,
    this.isClaimed = false,
  });
}

class SeasonManager extends ChangeNotifier {
  final EconomyManager _economyManager;

  int _seasonXp = 0;
  static const int _xpPerLevel = 1000;

  final List<SeasonReward> _rewards = List.generate(
    10,
    (index) => SeasonReward(
      level: index + 1,
      coins: (index + 1) * 100,
      tokens: (index + 1) % 5 == 0 ? 50 : 0,
      description: 'Level ${index + 1} Reward',
    ),
  );

  SeasonManager(this._economyManager);

  int get seasonXp => _seasonXp;
  int get currentLevel => (_seasonXp / _xpPerLevel).floor() + 1;
  double get progressToNextLevel => (_seasonXp % _xpPerLevel) / _xpPerLevel;
  List<SeasonReward> get rewards => _rewards;

  void addXp(int amount) {
    if (amount <= 0) return;
    _seasonXp += amount;
    notifyListeners();
  }

  bool claimReward(int level) {
    if (level > currentLevel) return false;

    final rewardIndex = _rewards.indexWhere((r) => r.level == level);
    if (rewardIndex == -1) return false;

    final reward = _rewards[rewardIndex];
    if (reward.isClaimed) return false;

    // Grant rewards
    if (reward.coins > 0) _economyManager.addCoins(reward.coins);
    if (reward.tokens > 0) _economyManager.addTokens(reward.tokens);

    reward.isClaimed = true;
    notifyListeners();
    return true;
  }
}
