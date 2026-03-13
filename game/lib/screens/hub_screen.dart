import 'package:flutter/material.dart';
import 'raid_screen.dart';
import 'team_screen.dart';
import 'shop_screen.dart';
import 'season_screen.dart';
import 'guild_screen.dart';
import 'leaderboard_screen.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legend Festival Hub')),
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
                title: const Text('Guild War'),
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
                title: const Text('Seasonal Event'),
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
            const SizedBox(height: 32),
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const TeamScreen()));
              },
              child: const Text('Manage Team'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ShopScreen()),
                );
              },
              child: const Text('Festival Shop'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SeasonScreen()),
                );
              },
              child: const Text('Season Pass'),
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
                  label: const Text('Guild'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                    );
                  },
                  icon: const Icon(Icons.leaderboard),
                  label: const Text('Rankings'),
                ),
              ],
            ),
    );
  }
}
