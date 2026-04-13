import 'package:mg_common_game/core/ui/layout/mg_spacing.dart';
import 'package:mg_common_game/core/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/meta/season_manager.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';import 'package:mg_common_game/l10n/localization.dart';


class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final season = context.watch<SeasonManager>();

    return Scaffold(
      appBar: AppBar(title: Text('ui_general_season_pass'.tr)),
      body: Column(
        children: [
          // Header Stats
          Container(
            padding: const EdgeInsets.all(MGSpacing.lg),
            color: Colors.deepPurple,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  'Level ${season.currentLevel}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: MGColors.textHighEmphasis,
                  ),
                ),
                const SizedBox(height: MGSpacing.xs),
                LinearProgressIndicator(
                  value: season.progressToNextLevel,
                  backgroundColor: Colors.white24,
                  color: Colors.amber,
                  minHeight: 12,
                ),
                const SizedBox(height: MGSpacing.xs),
                Text(
                  '${season.seasonXp % 1000} / 1000 XP',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // Rewards List
          Expanded(
            child: ListView.builder(
              itemCount: season.rewards.length,
              itemBuilder: (context, index) {
                final reward = season.rewards[index];
                final isUnlocked = season.currentLevel >= reward.level;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isUnlocked ? MGColors.success : MGColors.common,
                    child: Text('notification_rewardlevel'.tr),
                  ),
                  title: Text(reward.description),
                  subtitle: Text(
                    'Coins: ${reward.coins} | Tokens: ${reward.tokens}',
                  ),
                  trailing: reward.isClaimed
                      ? const Icon(Icons.check, color: MGColors.success)
                      : ElevatedButton(
                          onPressed: isUnlocked
                              ? () {
                                  if (context.read<SeasonManager>().claimReward(
                                    reward.level,
                                  )) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('notification_reward_claimed'.tr),
                                      ),
                                    );
                                  }
                                }
                              : null,
                          child: Text('notification_rewardslength_rewards_claimed'.tr),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
