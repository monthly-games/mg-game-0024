import 'package:flutter/foundation.dart';
import '../core/models.dart';

/// Character rarity tiers for the collection system.
enum CharacterRarity { common, uncommon, rare, epic, legendary }

/// Manages the character collection: display slots, unlock bonuses,
/// and rarity drop rates.
///
/// Integrates with [UpgradeManager] via three collection-category upgrades:
/// - `collection_slots`: number of display slots available
/// - `unlock_bonus`: reward multiplier when unlocking new characters
/// - `rarity_rate`: increased chance for rare+ characters
class CollectionManager extends ChangeNotifier {
  // ── Base constants ──────────────────────────────────────────────────
  static const int _baseSlots = 6;
  static const double _baseUnlockBonus = 1.0;
  static const double _baseRareChance = 0.10;
  static const double _maxRareChance = 0.80;

  // ── State ───────────────────────────────────────────────────────────
  int _slotBonus = 0;
  double _unlockBonus = 0.0;
  double _rarityBonus = 0.0;
  final List<HeroCharacter> _collection = [];
  final Set<String> _unlockedIds = {};

  // ── Getters ─────────────────────────────────────────────────────────
  int get totalSlots => _baseSlots + _slotBonus;
  double get unlockMultiplier => _baseUnlockBonus + _unlockBonus;
  double get rareDropChance =>
      (_baseRareChance + _rarityBonus).clamp(0.0, _maxRareChance);
  List<HeroCharacter> get collection => List.unmodifiable(_collection);
  int get collectionSize => _collection.length;
  int get availableSlots =>
      (totalSlots - _collection.length).clamp(0, totalSlots);
  bool get hasAvailableSlots => _collection.length < totalSlots;
  int get slotBonus => _slotBonus;
  double get unlockBonusValue => _unlockBonus;
  double get rarityBonusValue => _rarityBonus;

  // ── Upgrade application ─────────────────────────────────────────────

  void applySlotsUpgrade(double upgradeValue) {
    _slotBonus = upgradeValue.toInt();
    notifyListeners();
  }

  void applyUnlockBonusUpgrade(double upgradeValue) {
    _unlockBonus = upgradeValue;
    notifyListeners();
  }

  void applyRarityUpgrade(double upgradeValue) {
    _rarityBonus = upgradeValue;
    notifyListeners();
  }

  // ── Collection operations ───────────────────────────────────────────

  /// Adds a character to the collection if slots are available.
  /// Returns the unlock bonus reward value, or 0 if slot unavailable.
  double addToCollection(HeroCharacter hero) {
    if (!hasAvailableSlots) return 0.0;
    if (_unlockedIds.contains(hero.id)) return 0.0;

    _collection.add(hero);
    _unlockedIds.add(hero.id);
    notifyListeners();

    // Reward is proportional to hero power and unlock multiplier.
    return hero.power * 0.1 * unlockMultiplier;
  }

  /// Whether the given hero has already been collected.
  bool isCollected(String heroId) => _unlockedIds.contains(heroId);

  /// Collection completion ratio (0.0 to 1.0).
  double get completionRatio {
    if (totalSlots == 0) return 0.0;
    return _collection.length / totalSlots;
  }

  /// Determines rarity for a newly encountered character.
  /// Higher [rareDropChance] shifts the distribution upward.
  CharacterRarity rollRarity(double randomValue) {
    final rare = rareDropChance;
    if (randomValue < rare * 0.1) return CharacterRarity.legendary;
    if (randomValue < rare * 0.3) return CharacterRarity.epic;
    if (randomValue < rare) return CharacterRarity.rare;
    if (randomValue < rare + 0.30) return CharacterRarity.uncommon;
    return CharacterRarity.common;
  }
}
