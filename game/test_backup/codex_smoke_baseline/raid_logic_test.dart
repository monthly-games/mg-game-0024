import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/raid/raid_manager.dart';

void main() {
  group('Raid Logic Tests', () {
    test('Raid Starts correctly', () {
      final manager = RaidManager();
      expect(manager.state, RaidState.idle);

      manager.startRaid();

      expect(manager.state, RaidState.active);
      expect(manager.currentBoss, isNotNull);
      expect(manager.currentBoss!.name, 'Void Dragon');
    });

    test('Damage reduces Boss HP', () {
      final manager = RaidManager();
      manager.startRaid();
      final double initialHp = manager.currentBoss!.currentHp;

      manager.dealDamage(100);

      expect(manager.currentBoss!.currentHp, initialHp - 100);
      expect(manager.totalDamageDealt, 100);
    });

    test('Boss death triggers Victory', () {
      final manager = RaidManager();
      manager.startRaid();

      // Deal massive damage to kill
      manager.dealDamage(10000);

      expect(manager.currentBoss!.currentHp, 0);
      expect(manager.state, RaidState.victory);
    });

    test('Ending raid clears state', () {
      final manager = RaidManager();
      manager.startRaid();
      manager.endRaid();

      expect(manager.state, RaidState.idle);
      expect(manager.currentBoss, isNull);
    });
  });
}
