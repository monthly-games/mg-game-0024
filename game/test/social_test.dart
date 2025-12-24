import 'package:flutter_test/flutter_test.dart';
import 'package:game/features/social/social_manager.dart';

void main() {
  group('Social Tests', () {
    test('Can create and leave guild', () {
      final manager = SocialManager();
      expect(manager.currentGuild, isNull);

      manager.createGuild('Legends', 'Best guild ever');

      expect(manager.currentGuild, isNotNull);
      expect(manager.currentGuild!.name, 'Legends');
      expect(manager.currentGuild!.members.length, 1);
      expect(manager.currentGuild!.members.first.role, 'Leader');

      manager.leaveGuild();
      expect(manager.currentGuild, isNull);
    });

    test('Leaderboard generates entries', () {
      final manager = SocialManager();
      expect(manager.globalLeaderboard.isNotEmpty, true);
      expect(manager.globalLeaderboard.length, 10);

      // Check sorting (Rank 1 should satisfy score >= Rank 2)
      final rank1 = manager.globalLeaderboard[0];
      final rank2 = manager.globalLeaderboard[1];

      expect(rank1.rank, 1);
      expect(rank1.score >= rank2.score, true);
    });
  });
}
