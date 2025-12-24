import 'package:equatable/equatable.dart';

class Guild extends Equatable {
  final String id;
  final String name;
  final String description;
  final int level;
  final List<GuildMember> members;

  const Guild({
    required this.id,
    required this.name,
    this.description = '',
    this.level = 1,
    this.members = const [],
  });

  Guild copyWith({
    String? name,
    String? description,
    int? level,
    List<GuildMember>? members,
  }) {
    return Guild(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      level: level ?? this.level,
      members: members ?? this.members,
    );
  }

  @override
  List<Object?> get props => [id, name, description, level, members];
}

class GuildMember extends Equatable {
  final String name;
  final String role; // 'Leader', 'Member'
  final int contribution;
  final bool isOnline;

  const GuildMember({
    required this.name,
    required this.role,
    this.contribution = 0,
    this.isOnline = false,
  });

  @override
  List<Object?> get props => [name, role, contribution, isOnline];
}

class LeaderboardEntry extends Equatable {
  final String playerName;
  final int score;
  final int rank;

  const LeaderboardEntry({
    required this.playerName,
    required this.score,
    required this.rank,
  });

  @override
  List<Object?> get props => [playerName, score, rank];
}
