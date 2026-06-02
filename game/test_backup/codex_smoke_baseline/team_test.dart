import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/team/team_manager.dart';

void main() {
  group('Team Logic Tests', () {
    test('Can add heroes up to 4', () {
      final manager = TeamManager();
      final heroes = manager.roster;

      manager.addToTeam(heroes[0]);
      manager.addToTeam(heroes[1]);
      manager.addToTeam(heroes[2]);
      manager.addToTeam(heroes[3]);

      expect(manager.activeTeam.members.length, 4);

      // Try adding 5th
      manager.addToTeam(heroes[4]);
      expect(manager.activeTeam.members.length, 4); // Should still receive 4
    });

    test('Synergy Calculation - 2 Same Game', () {
      final manager = TeamManager();
      // Tech Commander (Colony Frontier)
      final h1 = manager.roster.firstWhere((h) => h.id == 'h_0023_1');
      // Mars Rover (Colony Frontier)
      final h2 = manager.roster.firstWhere((h) => h.id == 'h_0023_2');

      manager.addToTeam(h1);
      manager.addToTeam(h2);

      // Base Power: 1200 + 800 = 2000
      // Synergy: 2 same game -> +10% (1.1x)
      // Total: 2200

      expect(manager.activeTeam.totalPower, 2200);
      expect(manager.activeTeam.synergyMultiplier, 1.1);
    });

    test('Remove member updates team', () {
      final manager = TeamManager();
      final h1 = manager.roster[0];
      manager.addToTeam(h1);

      expect(manager.activeTeam.members.length, 1);

      manager.removeFromTeam(h1);

      expect(manager.activeTeam.members.isEmpty, true);
    });
  });
}
