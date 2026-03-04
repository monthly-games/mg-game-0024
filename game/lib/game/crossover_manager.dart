import 'package:flutter/foundation.dart';
import '../core/team_model.dart';

/// Manages crossover bonuses and enhanced team synergy calculations.
///
/// Integrates with [UpgradeManager] via two crossover-category upgrades:
/// - `crossover_bonus`: multiplier for cross-game hero bonuses
/// - `team_synergy`: enhanced synergy when mixing heroes from different games
class CrossoverManager extends ChangeNotifier {
  // ── Base constants ──────────────────────────────────────────────────
  static const double _crossoverPerGameTier = 0.10;
  static const int _maxCrossoverTiers = 4;

  // ── State ───────────────────────────────────────────────────────────
  double _crossoverBonus = 0.0;
  double _synergyBonus = 0.0;

  // ── Getters ─────────────────────────────────────────────────────────
  double get crossoverMultiplier => 1.0 + _crossoverBonus;
  double get synergyMultiplier => 1.0 + _synergyBonus;
  double get crossoverBonus => _crossoverBonus;
  double get synergyBonus => _synergyBonus;

  // ── Upgrade application ─────────────────────────────────────────────

  void applyCrossoverUpgrade(double upgradeValue) {
    _crossoverBonus = upgradeValue;
    notifyListeners();
  }

  void applySynergyUpgrade(double upgradeValue) {
    _synergyBonus = upgradeValue;
    notifyListeners();
  }

  // ── Crossover calculations ──────────────────────────────────────────

  /// Counts unique source games represented in the team.
  int getUniqueGameCount(Team team) {
    return team.members.map((hero) => hero.fromGame).toSet().length;
  }

  /// Base crossover bonus before upgrade multiplier.
  /// Each unique game source beyond the first adds [_crossoverPerGameTier].
  double _baseCrossoverBonus(Team team) {
    final uniqueGames = getUniqueGameCount(team);
    final tiers = (uniqueGames - 1).clamp(0, _maxCrossoverTiers);
    return tiers * _crossoverPerGameTier;
  }

  /// Returns the total crossover multiplier for a team,
  /// factoring in both base bonus and the crossover upgrade.
  double calculateTeamCrossoverBonus(Team team) {
    return _baseCrossoverBonus(team) * crossoverMultiplier;
  }

  /// Returns the team's synergy multiplier enhanced by the synergy upgrade.
  double getEnhancedSynergyMultiplier(Team team) {
    return team.synergyMultiplier + (_synergyBonus * team.synergyMultiplier);
  }

  /// Total team power accounting for crossover and enhanced synergy.
  double getEnhancedTeamPower(Team team) {
    if (team.members.isEmpty) return 0.0;
    final basePower = team.members.fold<double>(
      0,
      (sum, hero) => sum + hero.power,
    );
    final crossover = 1.0 + calculateTeamCrossoverBonus(team);
    final synergy = getEnhancedSynergyMultiplier(team);
    return basePower * crossover * synergy;
  }
}
