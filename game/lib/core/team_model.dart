import 'package:equatable/equatable.dart';
import 'models.dart';

class Team extends Equatable {
  final List<HeroCharacter> members;

  const Team({this.members = const []});

  bool get isFull => members.length >= 4;

  double get totalPower {
    double basePower = members.fold(0, (sum, hero) => sum + hero.power);
    return basePower * synergyMultiplier;
  }

  double get synergyMultiplier {
    if (members.isEmpty) return 1.0;

    Map<String, int> gameCounts = {};
    for (var hero in members) {
      gameCounts[hero.fromGame] = (gameCounts[hero.fromGame] ?? 0) + 1;
    }

    double multiplier = 1.0;

    // Logic:
    // 2 heroes same game: +10% (1.1x)
    // 3 heroes same game: +20% (1.2x)
    // 4 heroes same game: +30% (1.3x)
    // Bonuses stack if multiple pairs exist (e.g. 2 from Game A, 2 from Game B -> 1.21x or 1.2x? Let's make it additive for simplicity 1 + 0.1 + 0.1 = 1.2x)

    gameCounts.forEach((game, count) {
      if (count >= 2) multiplier += 0.1;
      if (count >= 3) multiplier += 0.1;
      if (count >= 4) multiplier += 0.1;
    });

    return multiplier;
  }

  Team addMember(HeroCharacter hero) {
    if (members.length >= 4) return this;
    if (members.contains(hero)) return this;
    return Team(members: [...members, hero]);
  }

  Team removeMember(HeroCharacter hero) {
    return Team(members: members.where((m) => m != hero).toList());
  }

  @override
  List<Object?> get props => [members];
}
