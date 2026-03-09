import 'package:flutter/material.dart';
import 'package:mg_common_game/systems/progression/achievement_manager.dart';
import 'package:mg_common_game/systems/quests/daily_quest.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:mg_common_game/systems/progression/upgrade_manager.dart';
import 'features/meta/economy_manager.dart';
import 'features/meta/season_manager.dart';
import 'features/social/social_manager.dart';
import 'features/raid/raid_manager.dart';
import 'features/team/team_manager.dart';
import 'game/character_manager.dart';
import 'game/crossover_manager.dart';
import 'game/collection_manager.dart';
import 'screens/hub_screen.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';

// ═══════════════════════════════════════════════════════════════════════
// Crossover Hub — MG-0024 (Legend Festival)
// Genre: Puzzle / Crossover / Collection
// Region: LATAM
//
// Core loop: Collect Heroes -> Build Crossover Teams -> Raid Bosses
// Subsystems: Character power, Crossover bonuses, Collection,
//             Team synergy, Economy, Seasons, Upgrades
// ═══════════════════════════════════════════════════════════════════════

/// LATAM region accent color (Crimson Red #DC143C).
const Color _kLatamRed = MGColors.error;

/// Dark background for festival theme.
const Color _kFestivalBg = Color(0xFF1A0A1E);

/// Card / AppBar surface color.
const Color _kFestivalSurface = Color(0xFF2D1233);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeSystems();
  // DailyQuest 시스템
  GetIt.I.registerSingleton(DailyQuestManager());
  // Achievement 시스템
  GetIt.I.registerSingleton(AchievementManager());
  _registerAchievements();
  _registerDailyQuests();
  runApp(const LegendFestivalApp());
}

// ─── System Initialization ─────────────────────────────────────────────

/// Registers all DI-managed systems. mg_common_game systems first,
/// then game-specific managers in correct dependency order.
Future<void> _initializeSystems() async {
  final di = GetIt.I;

  // ── mg_common_game core: UpgradeManager ──────────────────────────
  if (!di.isRegistered<UpgradeManager>()) {
    final upgrades = UpgradeManager();
    di.registerSingleton<UpgradeManager>(upgrades);
    _registerUpgrades(upgrades);
    await upgrades.loadUpgrades();
  }

  // ── Existing game managers ────────────────────────────────────────
  if (!di.isRegistered<EconomyManager>()) {
    di.registerSingleton<EconomyManager>(EconomyManager());
  }

  if (!di.isRegistered<RaidManager>()) {
    di.registerSingleton<RaidManager>(RaidManager());
  }

  if (!di.isRegistered<TeamManager>()) {
    di.registerSingleton<TeamManager>(TeamManager());
  }

  if (!di.isRegistered<SocialManager>()) {
    di.registerSingleton<SocialManager>(SocialManager());
  }

  if (!di.isRegistered<SeasonManager>()) {
    di.registerSingleton<SeasonManager>(
      SeasonManager(di.get<EconomyManager>()),
    );
  }

  // ── New mechanic managers ────────────────────────────────────────
  if (!di.isRegistered<CharacterManager>()) {
    di.registerSingleton<CharacterManager>(CharacterManager());
  }

  if (!di.isRegistered<CrossoverManager>()) {
    di.registerSingleton<CrossoverManager>(CrossoverManager());
  }

  if (!di.isRegistered<CollectionManager>()) {
    di.registerSingleton<CollectionManager>(CollectionManager());
  }

  // Apply saved upgrade effects to managers
  _applyUpgradeEffects(di.get<UpgradeManager>());
}

// ═══════════════════════════════════════════════════════════════════════
// Upgrade Registration — 8 crossover-hub upgrades
// Categories: character (3), crossover (2), collection (3)
// ═══════════════════════════════════════════════════════════════════════

void _registerUpgrades(UpgradeManager manager) {
  // ── Character upgrades (3) ──────────────────────────────────────

  manager.registerUpgrade(Upgrade(
    id: 'character_power',
    name: 'Hero Power',
    description: 'Boosts base power of all collected heroes by 12% per level.',
    maxLevel: 15,
    baseCost: 80,
    costMultiplier: 1.45,
    valuePerLevel: 0.12,
  ));

  manager.registerUpgrade(Upgrade(
    id: 'ability_strength',
    name: 'Ability Mastery',
    description: 'Increases hero ability damage by 15% per level.',
    maxLevel: 12,
    baseCost: 120,
    costMultiplier: 1.5,
    valuePerLevel: 0.15,
  ));

  manager.registerUpgrade(Upgrade(
    id: 'level_cap',
    name: 'Legend Ascension',
    description: 'Raises max hero level by 5 per upgrade level.',
    maxLevel: 10,
    baseCost: 200,
    costMultiplier: 1.8,
    valuePerLevel: 5.0,
  ));

  // ── Crossover upgrades (2) ──────────────────────────────────────

  manager.registerUpgrade(Upgrade(
    id: 'crossover_bonus',
    name: 'Festival Alliance',
    description: 'Multiplies cross-game hero bonuses by 10% per level.',
    maxLevel: 10,
    baseCost: 150,
    costMultiplier: 1.55,
    valuePerLevel: 0.10,
  ));

  manager.registerUpgrade(Upgrade(
    id: 'team_synergy',
    name: 'Legendary Synergy',
    description: 'Enhances team synergy multiplier by 8% per level.',
    maxLevel: 12,
    baseCost: 180,
    costMultiplier: 1.6,
    valuePerLevel: 0.08,
  ));

  // ── Collection upgrades (3) ─────────────────────────────────────

  manager.registerUpgrade(Upgrade(
    id: 'collection_slots',
    name: 'Hero Gallery',
    description: 'Adds 2 collection display slots per level.',
    maxLevel: 10,
    baseCost: 100,
    costMultiplier: 1.4,
    valuePerLevel: 2.0,
  ));

  manager.registerUpgrade(Upgrade(
    id: 'unlock_bonus',
    name: 'Discovery Reward',
    description: 'Boosts rewards from unlocking new heroes by 20% per level.',
    maxLevel: 10,
    baseCost: 90,
    costMultiplier: 1.45,
    valuePerLevel: 0.20,
  ));

  manager.registerUpgrade(Upgrade(
    id: 'rarity_rate',
    name: 'Fate Weaver',
    description: 'Increases rare hero encounter rate by 3% per level.',
    maxLevel: 8,
    baseCost: 250,
    costMultiplier: 1.7,
    valuePerLevel: 0.03,
  ));
}

// ─── Upgrade Effect Application ────────────────────────────────────────

/// Reads current upgrade levels and pushes computed values into
/// the corresponding game managers.
void _applyUpgradeEffects(UpgradeManager upgradeManager) {
  final di = GetIt.I;

  // Character upgrades -> CharacterManager
  final characterManager = di.get<CharacterManager>();

  final charPower = upgradeManager.getUpgrade('character_power');
  if (charPower != null) {
    characterManager.applyPowerUpgrade(charPower.currentValue);
  }

  final abilityStrength = upgradeManager.getUpgrade('ability_strength');
  if (abilityStrength != null) {
    characterManager.applyAbilityUpgrade(abilityStrength.currentValue);
  }

  final levelCap = upgradeManager.getUpgrade('level_cap');
  if (levelCap != null) {
    characterManager.applyLevelCapUpgrade(levelCap.currentValue);
  }

  // Crossover upgrades -> CrossoverManager
  final crossoverManager = di.get<CrossoverManager>();

  final crossoverBonus = upgradeManager.getUpgrade('crossover_bonus');
  if (crossoverBonus != null) {
    crossoverManager.applyCrossoverUpgrade(crossoverBonus.currentValue);
  }

  final teamSynergy = upgradeManager.getUpgrade('team_synergy');
  if (teamSynergy != null) {
    crossoverManager.applySynergyUpgrade(teamSynergy.currentValue);
  }

  // Collection upgrades -> CollectionManager
  final collectionManager = di.get<CollectionManager>();

  final collectionSlots = upgradeManager.getUpgrade('collection_slots');
  if (collectionSlots != null) {
    collectionManager.applySlotsUpgrade(collectionSlots.currentValue);
  }

  final unlockBonus = upgradeManager.getUpgrade('unlock_bonus');
  if (unlockBonus != null) {
    collectionManager.applyUnlockBonusUpgrade(unlockBonus.currentValue);
  }

  final rarityRate = upgradeManager.getUpgrade('rarity_rate');
  if (rarityRate != null) {
    collectionManager.applyRarityUpgrade(rarityRate.currentValue);
  }
}

// ═══════════════════════════════════════════════════════════════════════
// App Root — MultiProvider wraps all game state
// ═══════════════════════════════════════════════════════════════════════

class LegendFestivalApp extends StatelessWidget {
  const LegendFestivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Existing managers
        ChangeNotifierProvider.value(value: GetIt.I<EconomyManager>()),
        ChangeNotifierProvider.value(value: GetIt.I<RaidManager>()),
        ChangeNotifierProvider.value(value: GetIt.I<TeamManager>()),
        ChangeNotifierProvider.value(value: GetIt.I<SocialManager>()),
        ChangeNotifierProvider.value(value: GetIt.I<SeasonManager>()),
        // New mechanic managers
        ChangeNotifierProvider.value(value: GetIt.I<CharacterManager>()),
        ChangeNotifierProvider.value(value: GetIt.I<CrossoverManager>()),
        ChangeNotifierProvider.value(value: GetIt.I<CollectionManager>()),
        // Core progression
        ChangeNotifierProvider.value(value: GetIt.I<UpgradeManager>()),
      ],
      child: MaterialApp(
        title: 'Legend Festival',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        home: const HubScreen(),
      ),
    );
  }

  /// LATAM-themed vibrant festival palette with dark mode.
  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kLatamRed,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: _kFestivalBg,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _kFestivalSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        color: _kFestivalSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Upgrade Display Widget — reusable upgrade-list UI integration
// ═══════════════════════════════════════════════════════════════════════

/// Displays all registered upgrades grouped by category.
/// Purchase triggers [_applyUpgradeEffects] to synchronize managers.
class UpgradeListWidget extends StatelessWidget {
  const UpgradeListWidget({super.key});

  /// Upgrade IDs grouped by category for display ordering.
  static const Map<String, List<String>> _upgradeCategories = {
    'Character': ['character_power', 'ability_strength', 'level_cap'],
    'Crossover': ['crossover_bonus', 'team_synergy'],
    'Collection': ['collection_slots', 'unlock_bonus', 'rarity_rate'],
  };

  @override
  Widget build(BuildContext context) {
    return Consumer2<UpgradeManager, EconomyManager>(
      builder: (context, upgrades, economy, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: _upgradeCategories.entries.map((category) {
            return _buildCategorySection(
              context,
              category.key,
              category.value,
              upgrades,
              economy,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String title,
    List<String> upgradeIds,
    UpgradeManager upgrades,
    EconomyManager economy,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _kLatamRed,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...upgradeIds.map((id) {
          final upgrade = upgrades.getUpgrade(id);
          if (upgrade == null) return const SizedBox.shrink();
          return _buildUpgradeTile(context, upgrade, upgrades, economy);
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildUpgradeTile(
    BuildContext context,
    Upgrade upgrade,
    UpgradeManager upgrades,
    EconomyManager economy,
  ) {
    final isMaxLevel = upgrade.currentLevel >= upgrade.maxLevel;
    final cost = upgrade.costForNextLevel;
    final canAfford = !isMaxLevel && economy.festivalCoins >= cost;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          '${upgrade.name}  Lv.${upgrade.currentLevel}/${upgrade.maxLevel}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(upgrade.description),
        trailing: isMaxLevel
            ? const Chip(label: Text('MAX'))
            : ElevatedButton(
                onPressed: canAfford
                    ? () {
                        final purchased = upgrades.purchaseUpgrade(
                          upgrade.id,
                          () => economy.festivalCoins,
                          (spent) => economy.spendCoins(spent),
                        );
                        if (purchased) {
                          _applyUpgradeEffects(upgrades);
                        }
                      }
                    : null,
                child: Text('$cost coins'),
              ),
      ),
    );
  }
}


void _registerDailyQuests() {
  final dailyQuest = GetIt.I<DailyQuestManager>();
  
  dailyQuest.registerQuest(DailyQuest(
    id: 'collect_gold',
    title: '골드 모으기',
    description: '골드 1000 획득',
    targetValue: 1000,
    goldReward: 500,
    xpReward: 10,
  ));
  
  dailyQuest.registerQuest(DailyQuest(
    id: 'play_games',
    title: '게임 플레이',
    description: '게임 5판 플레이',
    targetValue: 5,
    goldReward: 300,
    xpReward: 5,
  ));
  
  dailyQuest.registerQuest(DailyQuest(
    id: 'level_up',
    title: '레벨업',
    description: '레벨 1 상승',
    targetValue: 1,
    goldReward: 200,
    xpReward: 3,
  ));
}


void _registerAchievements() {
  final achievement = GetIt.I<AchievementManager>();
  
  achievement.registerAchievement(Achievement(
    id: 'gold_1000',
    title: '골드 1000 달성',
    description: '총 골드 1000을 모으세요',
    iconAsset: 'assets/achievements/gold_1000.png',
  ));
  
  achievement.registerAchievement(Achievement(
    id: 'level_10',
    title: '레벨 10 달성',
    description: '레벨 10에 도달하세요',
    iconAsset: 'assets/achievements/level_10.png',
  ));
  
  achievement.registerAchievement(Achievement(
    id: 'play_100',
    title: '100판 플레이',
    description: '게임을 100판 플레이하세요',
    iconAsset: 'assets/achievements/play_100.png',
  ));
}
