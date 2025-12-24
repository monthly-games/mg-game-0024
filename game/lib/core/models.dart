import 'package:equatable/equatable.dart';

enum HeroRole { dps, tank, support }

enum RaidElement { fire, water, earth, light, dark }

class RaidBoss extends Equatable {
  final String id;
  final String name;
  final double maxHp;
  final double currentHp;
  final RaidElement element;

  const RaidBoss({
    required this.id,
    required this.name,
    required this.maxHp,
    required this.currentHp,
    required this.element,
  });

  RaidBoss copyWith({
    String? id,
    String? name,
    double? maxHp,
    double? currentHp,
    RaidElement? element,
  }) {
    return RaidBoss(
      id: id ?? this.id,
      name: name ?? this.name,
      maxHp: maxHp ?? this.maxHp,
      currentHp: currentHp ?? this.currentHp,
      element: element ?? this.element,
    );
  }

  @override
  List<Object?> get props => [id, name, maxHp, currentHp, element];
}

class HeroCharacter extends Equatable {
  final String id;
  final String name;
  final String fromGame; // e.g., 'mg-game-0023'
  final int power;
  final HeroRole role;

  const HeroCharacter({
    required this.id,
    required this.name,
    required this.fromGame,
    required this.power,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, fromGame, power, role];
}
