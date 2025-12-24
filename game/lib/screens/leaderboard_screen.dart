import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/social/social_manager.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<SocialManager>();
    final entries = manager.globalLeaderboard;

    return Scaffold(
      appBar: AppBar(title: const Text('Rankings')),
      body: ListView.separated(
        itemCount: entries.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final entry = entries[index];
          return ListTile(
            leading: Text(
              '#${entry.rank}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            title: Text(entry.playerName),
            trailing: Text(
              '${entry.score}',
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
