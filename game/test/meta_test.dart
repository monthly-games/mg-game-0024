import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/meta/economy_manager.dart';
import 'package:game/features/meta/season_manager.dart';

void main() {
  group('Economy Tests', () {
    test('Can add and spend coins', () {
      final economy = EconomyManager();
      expect(economy.festivalCoins, 0);

      economy.addCoins(100);
      expect(economy.festivalCoins, 100);

      bool success = economy.spendCoins(50);
      expect(success, true);
      expect(economy.festivalCoins, 50);

      bool fail = economy.spendCoins(100);
      expect(fail, false);
      expect(economy.festivalCoins, 50);
    });
  });

  group('Season Tests', () {
    test('XP increases level', () {
      final economy = EconomyManager();
      final season = SeasonManager(economy);

      expect(season.currentLevel, 1);

      season.addXp(1500); // Should reach Level 2 (1000 threshold)

      expect(season.currentLevel, 2);
      expect(season.progressToNextLevel, 0.5); // 500/1000
    });

    test('Claiming reward grants currency', () {
      final economy = EconomyManager();
      final season = SeasonManager(economy);

      // Unlock Level 1 (Default available if level 1?)
      // Current level is 1. Reward for level 1 requires level >= 1.

      final result = season.claimReward(1);
      expect(result, true);

      // Level 1 rewards: 100 coins
      expect(economy.festivalCoins, 100);

      // Cannot claim again
      final doubleClaim = season.claimReward(1);
      expect(doubleClaim, false);
    });

    test('Cannot claim locked reward', () {
      final economy = EconomyManager();
      final season = SeasonManager(economy);

      // Try to claim Level 2
      final result = season.claimReward(2);
      expect(result, false);
    });
  });
}
