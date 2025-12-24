import 'dart:math';
import 'package:flutter/foundation.dart';
import 'social_models.dart';

class SocialManager extends ChangeNotifier {
  Guild? _currentGuild;
  List<LeaderboardEntry> _globalLeaderboard = [];

  Guild? get currentGuild => _currentGuild;
  List<LeaderboardEntry> get globalLeaderboard => _globalLeaderboard;

  SocialManager() {
    _generateMockLeaderboard();
  }

  void createGuild(String name, String description) {
    _currentGuild = Guild(
      id: 'g_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      description: description,
      members: const [
        GuildMember(
          name: 'Player',
          role: 'Leader',
          contribution: 0,
          isOnline: true,
        ),
      ],
    );
    notifyListeners();
  }

  void leaveGuild() {
    _currentGuild = null;
    notifyListeners();
  }

  // Simulation Methods
  void _generateMockLeaderboard() {
    final rng = Random();
    final names = [
      'DragonSlayer',
      'StarLord',
      'MoonWalker',
      'VoidSeeker',
      'IronHeart',
      'ShadowBlade',
    ];

    _globalLeaderboard = List.generate(10, (index) {
      return LeaderboardEntry(
        playerName: '${names[index % names.length]}#${rng.nextInt(9999)}',
        score: 50000 - (index * 2000) - rng.nextInt(1000),
        rank: index + 1,
      );
    });

    // Add Player (Mock)
    // In a real scenario, we'd insert the player based on their actual score.
    // Here we just append them or insert if we had a score.
  }
}
