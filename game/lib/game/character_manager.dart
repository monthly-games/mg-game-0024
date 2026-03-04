import 'package:flutter/foundation.dart';

/// Manages character power scaling, ability strength, and level progression.
///
/// Integrates with [UpgradeManager] via three character-category upgrades:
/// - `character_power`: base power multiplier per hero
/// - `ability_strength`: ability damage multiplier
/// - `level_cap`: maximum character level increase
class CharacterManager extends ChangeNotifier {
  // ── Base constants ──────────────────────────────────────────────────
  static const double _basePowerMultiplier = 1.0;
  static const double _baseAbilityMultiplier = 1.0;
  static const int _baseMaxLevel = 30;
  static const double _levelScalingFactor = 0.08;

  // ── State ───────────────────────────────────────────────────────────
  double _powerBonus = 0.0;
  double _abilityBonus = 0.0;
  int _levelCapBonus = 0;

  // ── Getters ─────────────────────────────────────────────────────────
  double get powerMultiplier => _basePowerMultiplier + _powerBonus;
  double get abilityMultiplier => _baseAbilityMultiplier + _abilityBonus;
  int get maxCharacterLevel => _baseMaxLevel + _levelCapBonus;
  double get powerBonus => _powerBonus;
  double get abilityBonus => _abilityBonus;
  int get levelCapBonus => _levelCapBonus;

  // ── Upgrade application ─────────────────────────────────────────────

  void applyPowerUpgrade(double upgradeValue) {
    _powerBonus = upgradeValue;
    notifyListeners();
  }

  void applyAbilityUpgrade(double upgradeValue) {
    _abilityBonus = upgradeValue;
    notifyListeners();
  }

  void applyLevelCapUpgrade(double upgradeValue) {
    _levelCapBonus = upgradeValue.toInt();
    notifyListeners();
  }

  // ── Character calculations ──────────────────────────────────────────

  /// Returns effective power after applying upgrade multipliers and
  /// level-based scaling.
  double getEffectivePower(int basePower, {int level = 1}) {
    final levelScale = 1.0 + (level - 1) * _levelScalingFactor;
    return basePower * powerMultiplier * levelScale;
  }

  /// Returns ability damage based on character power and ability multiplier.
  double getAbilityDamage(int basePower, {int level = 1}) {
    final effectivePower = getEffectivePower(basePower, level: level);
    return effectivePower * 0.5 * abilityMultiplier;
  }

  /// Whether a character at [currentLevel] can still level up.
  bool canLevelUp(int currentLevel) => currentLevel < maxCharacterLevel;

  /// Experience required to reach next level from [currentLevel].
  int expForNextLevel(int currentLevel) => 100 + currentLevel * 25;
}
