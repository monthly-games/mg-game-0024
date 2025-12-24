import 'package:flutter/foundation.dart';
import '../../core/models.dart';

enum RaidState { idle, active, victory, defeat }

class RaidManager extends ChangeNotifier {
  RaidBoss? _currentBoss;
  RaidState _state = RaidState.idle;
  double _totalDamageDealt = 0;

  // Getters
  RaidBoss? get currentBoss => _currentBoss;
  RaidState get state => _state;
  double get totalDamageDealt => _totalDamageDealt;

  // Dependencies (Prototype Injection via method or setter preferred, but constructor simplest for now if possible,
  // or we can just pass them in endRaid. Let's add a setup method or just use a callback/listener strategy.
  // Actually, simpler: let the Screen handle the wiring or add a helper.)
  // Let's rely on the Screen to call 'completeRaid' which then grants rewards?
  // Or better: RaidManager emits event.
  // For simplicity in this stack, let's allow passing generic callbacks or inject them.
  // Let's use `onRaidComplete` callback for now to not break DI structure too much in this fast iteration.

  Function(bool isWin)? onRaidComplete;

  void startRaid({Function(bool isWin)? onComplete}) {
    onRaidComplete = onComplete;
    // Prototype: Hardcoded Boss
    _currentBoss = const RaidBoss(
      id: 'boss_01',
      name: 'Void Dragon',
      maxHp: 10000,
      currentHp: 10000,
      element: RaidElement.dark,
    );
    _state = RaidState.active;
    _totalDamageDealt = 0;
    notifyListeners();
  }

  void dealDamage(double amount) {
    if (_state != RaidState.active || _currentBoss == null) return;

    double newHp = _currentBoss!.currentHp - amount;
    if (newHp < 0) newHp = 0;

    _currentBoss = _currentBoss!.copyWith(currentHp: newHp);
    _totalDamageDealt += amount;

    if (newHp <= 0) {
      _state = RaidState.victory;
      onRaidComplete?.call(true);
    }

    notifyListeners();
  }

  void endRaid() {
    if (_state != RaidState.victory &&
        _state != RaidState.defeat &&
        _state == RaidState.active) {
      // Manual retreat counts as loss? Or just no rewards.
      // Let's say no rewards on retreat.
    }
    _state = RaidState.idle;
    _currentBoss = null;
    notifyListeners();
  }
}
