import 'package:flutter/foundation.dart';
import '../../core/models.dart';
import '../../core/team_model.dart';

class TeamManager extends ChangeNotifier {
  Team _activeTeam = const Team();
  final List<HeroCharacter> _roster = _generateMockRoster();

  Team get activeTeam => _activeTeam;
  List<HeroCharacter> get roster => _roster;

  void addToTeam(HeroCharacter hero) {
    _activeTeam = _activeTeam.addMember(hero);
    notifyListeners();
  }

  void removeFromTeam(HeroCharacter hero) {
    _activeTeam = _activeTeam.removeMember(hero);
    notifyListeners();
  }

  bool isInTeam(HeroCharacter hero) {
    return _activeTeam.members.contains(hero);
  }

  static List<HeroCharacter> _generateMockRoster() {
    return [
      const HeroCharacter(
        id: 'h_0023_1',
        name: 'Tech Commander',
        fromGame: 'Colony Frontier',
        power: 1200,
        role: HeroRole.support,
      ),
      const HeroCharacter(
        id: 'h_0023_2',
        name: 'Mars Rover',
        fromGame: 'Colony Frontier',
        power: 800,
        role: HeroRole.tank,
      ),
      const HeroCharacter(
        id: 'h_0005_1',
        name: 'Dungeon Knight',
        fromGame: 'Roguelike Dungeon',
        power: 1500,
        role: HeroRole.dps,
      ),
      const HeroCharacter(
        id: 'h_0005_2',
        name: 'Skeleton Mage',
        fromGame: 'Roguelike Dungeon',
        power: 1350,
        role: HeroRole.dps,
      ),
      const HeroCharacter(
        id: 'h_0012_1',
        name: 'Raid Paladin',
        fromGame: 'Raid RPG',
        power: 1400,
        role: HeroRole.tank,
      ),
      const HeroCharacter(
        id: 'h_0012_2',
        name: 'Shadow Assassin',
        fromGame: 'Raid RPG',
        power: 1600,
        role: HeroRole.dps,
      ),
    ];
  }
}
