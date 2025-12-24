import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/meta/economy_manager.dart';
import 'features/meta/season_manager.dart';
import 'features/social/social_manager.dart';
import 'features/raid/raid_manager.dart';
import 'features/team/team_manager.dart';
import 'screens/hub_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RaidManager()),
        ChangeNotifierProvider(create: (_) => TeamManager()),
        ChangeNotifierProvider(create: (_) => EconomyManager()),
        ChangeNotifierProvider(create: (_) => SocialManager()),
        ChangeNotifierProxyProvider<EconomyManager, SeasonManager>(
          create: (ctx) => SeasonManager(ctx.read<EconomyManager>()),
          update: (ctx, economy, previous) =>
              previous ?? SeasonManager(economy),
        ),
      ],
      child: const LegendFestivalApp(),
    ),
  );
}

class LegendFestivalApp extends StatelessWidget {
  const LegendFestivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legend Festival',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HubScreen(),
    );
  }
}
