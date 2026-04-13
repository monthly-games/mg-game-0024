import 'package:mg_common_game/core/ui/layout/mg_spacing.dart';
import 'package:mg_common_game/core/localization/localization.dart';
import 'package:flutter/material.dart';
import 'raid_screen.dart';
import 'team_screen.dart';
import 'shop_screen.dart';
import 'season_screen.dart';
import 'guild_screen.dart';
import 'leaderboard_screen.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';import 'package:mg_common_game/l10n/localization.dart';


class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ui_general_legend_festival_hub'.tr)),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Color(0xFF1A237E)),
                child: Text('Community',
                    style: TextStyle(
                        color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: const Icon(Icons.shield),
                title: Text('ui_general_guild_war'.tr),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed('/guild-war');
                },
              ),
              ListTile(
                leading: const Icon(Icons.emoji_events),
                title: const Text('Tournament'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed('/tournament');
                },
              ),
              ListTile(
                leading: const Icon(Icons.celebration),
                title: Text('ui_general_seasonal_event'.tr),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed('/seasonal-event');
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome, Commander!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: MGSpacing.xl),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const RaidScreen()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                backgroundColor: Colors.redAccent,
              ),
              child: const Text(
                'ENTER RAID',
                style: TextStyle(fontSize: 18, color: MGColors.textHighEmphasis),
              ),
            ),
            const SizedBox(height: MGSpacing.md),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const TeamScreen()));
              },
              child: Text('ui_general_manage_team'.tr),
            ),
            const SizedBox(height: MGSpacing.md),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ShopScreen()),
                );
              },
              child: Text('shop_festival_shop'.tr),
            ),
            const SizedBox(height: MGSpacing.md),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SeasonScreen()),
                );
              },
              child: Text('ui_general_season_pass'.tr),
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const GuildScreen()),
                    );
                  },
                  icon: const Icon(Icons.shield),
                  label: Text('ui_general_guild_war'.tr),
                ),
                const SizedBox(width: MGSpacing.md),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                    );
                  },
                  icon: const Icon(Icons.leaderboard),
                  label: Text('progress_global_rankings'.tr),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
