import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/audio_controller.dart';
import '../features/meta/economy_manager.dart';
import '../features/meta/season_manager.dart';
import '../features/raid/game/raid_game.dart';
import '../features/raid/raid_manager.dart';

class RaidScreen extends StatefulWidget {
  const RaidScreen({super.key});

  @override
  State<RaidScreen> createState() => _RaidScreenState();
}

class _RaidScreenState extends State<RaidScreen> {
  late RaidGame _game;

  @override
  void initState() {
    super.initState();
    final manager = context.read<RaidManager>();
    final economy = context.read<EconomyManager>();
    final season = context.read<SeasonManager>();

    manager.startRaid(
      onComplete: (isWin) {
        if (isWin) {
          economy.addCoins(100);
          season.addXp(50);
          // We could show a specific "Rewards" dialog here too, but ResultOverlay handles the "Victory" text.
        }
      },
    );
    _game = RaidGame(manager);

    // Play BGM
    AudioController().playBgm('bgm_raid.mp3');
  }

  @override
  void dispose() {
    AudioController().stopBgm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Flame Game Layer
          GameWidget(game: _game),

          // UI Overlay Layer
          SafeArea(
            child: Column(
              children: [
                // Boss HP Bar
                _BossHealthBar(),

                const Spacer(),

                // Quit Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<RaidManager>().endRaid();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('RETREAT'),
                  ),
                ),
              ],
            ),
          ),

          // Victory/Defeat Overlay
          const _ResultOverlay(),
        ],
      ),
    );
  }
}

class _BossHealthBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final manager = context.watch<RaidManager>();
    final boss = manager.currentBoss;

    if (boss == null) return const SizedBox.shrink();

    final percentage = boss.currentHp / boss.maxHp;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            boss.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 4, color: Colors.black)],
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            minHeight: 20,
            backgroundColor: Colors.black54,
            color: Colors.red,
          ),
          const SizedBox(height: 4),
          Text(
            '${boss.currentHp.toInt()} / ${boss.maxHp.toInt()}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ResultOverlay extends StatelessWidget {
  const _ResultOverlay();

  @override
  Widget build(BuildContext context) {
    final state = context.select((RaidManager m) => m.state);

    if (state == RaidState.victory) {
      return Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'VICTORY!',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<RaidManager>().endRaid();
                  Navigator.of(context).pop();
                },
                child: const Text('Return to Hub'),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
