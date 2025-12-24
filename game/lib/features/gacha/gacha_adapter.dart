/// 가챠 시스템 어댑터 - MG-0024 Festival Event
library;

import 'package:flutter/foundation.dart';
import 'package:mg_common_game/systems/gacha/gacha_config.dart';
import 'package:mg_common_game/systems/gacha/gacha_manager.dart';

/// 게임 내 Performer 모델
class Performer {
  final String id;
  final String name;
  final GachaRarity rarity;
  final Map<String, dynamic> stats;

  const Performer({
    required this.id,
    required this.name,
    required this.rarity,
    this.stats = const {},
  });
}

/// Festival Event 가챠 어댑터
class PerformerGachaAdapter extends ChangeNotifier {
  final GachaManager _gachaManager = GachaManager(
    pityConfig: const PityConfig(
      softPityStart: 70,
      hardPity: 80,
      softPityBonus: 6.0,
    ),
    multiPullGuarantee: const MultiPullGuarantee(
      minRarity: GachaRarity.rare,
    ),
  );

  static const String _poolId = 'festival_pool';

  PerformerGachaAdapter() {
    _initPool();
  }

  void _initPool() {
    final pool = GachaPool(
      id: _poolId,
      name: 'Festival Event 가챠',
      items: _generateItems(),
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 365)),
    );
    _gachaManager.registerPool(pool);
  }

  List<GachaItem> _generateItems() {
    return [
      // UR (0.6%)
      GachaItem(id: 'ur_festival_001', name: '전설의 Performer', rarity: GachaRarity.ultraRare, weight: 1.0),
      GachaItem(id: 'ur_festival_002', name: '신화의 Performer', rarity: GachaRarity.ultraRare, weight: 1.0),
      // SSR (2.4%)
      GachaItem(id: 'ssr_festival_001', name: '영웅의 Performer', rarity: GachaRarity.superSuperRare, weight: 1.0),
      GachaItem(id: 'ssr_festival_002', name: '고대의 Performer', rarity: GachaRarity.superSuperRare, weight: 1.0),
      GachaItem(id: 'ssr_festival_003', name: '황금의 Performer', rarity: GachaRarity.superSuperRare, weight: 1.0),
      // SR (12%)
      GachaItem(id: 'sr_festival_001', name: '희귀한 Performer A', rarity: GachaRarity.superRare, weight: 1.0),
      GachaItem(id: 'sr_festival_002', name: '희귀한 Performer B', rarity: GachaRarity.superRare, weight: 1.0),
      GachaItem(id: 'sr_festival_003', name: '희귀한 Performer C', rarity: GachaRarity.superRare, weight: 1.0),
      GachaItem(id: 'sr_festival_004', name: '희귀한 Performer D', rarity: GachaRarity.superRare, weight: 1.0),
      // R (35%)
      GachaItem(id: 'r_festival_001', name: '우수한 Performer A', rarity: GachaRarity.rare, weight: 1.0),
      GachaItem(id: 'r_festival_002', name: '우수한 Performer B', rarity: GachaRarity.rare, weight: 1.0),
      GachaItem(id: 'r_festival_003', name: '우수한 Performer C', rarity: GachaRarity.rare, weight: 1.0),
      GachaItem(id: 'r_festival_004', name: '우수한 Performer D', rarity: GachaRarity.rare, weight: 1.0),
      GachaItem(id: 'r_festival_005', name: '우수한 Performer E', rarity: GachaRarity.rare, weight: 1.0),
      // N (50%)
      GachaItem(id: 'n_festival_001', name: '일반 Performer A', rarity: GachaRarity.normal, weight: 1.0),
      GachaItem(id: 'n_festival_002', name: '일반 Performer B', rarity: GachaRarity.normal, weight: 1.0),
      GachaItem(id: 'n_festival_003', name: '일반 Performer C', rarity: GachaRarity.normal, weight: 1.0),
      GachaItem(id: 'n_festival_004', name: '일반 Performer D', rarity: GachaRarity.normal, weight: 1.0),
      GachaItem(id: 'n_festival_005', name: '일반 Performer E', rarity: GachaRarity.normal, weight: 1.0),
      GachaItem(id: 'n_festival_006', name: '일반 Performer F', rarity: GachaRarity.normal, weight: 1.0),
    ];
  }

  /// 단일 뽑기
  Performer? pullSingle() {
    final result = _gachaManager.pull(_poolId);
    if (result == null) return null;
    notifyListeners();
    return _convertToItem(result);
  }

  /// 10연차
  List<Performer> pullTen() {
    final results = _gachaManager.pullMulti(_poolId, 10);
    notifyListeners();
    return results.map(_convertToItem).toList();
  }

  Performer _convertToItem(GachaItem item) {
    return Performer(
      id: item.id,
      name: item.name,
      rarity: item.rarity,
    );
  }

  /// 천장까지 남은 횟수
  int get pullsUntilPity => _gachaManager.pullsUntilPity(_poolId);

  /// 총 뽑기 횟수
  int get totalPulls => _gachaManager.getTotalPulls(_poolId);

  /// 통계
  Map<GachaRarity, int> get stats => _gachaManager.getStatistics(_poolId);

  Map<String, dynamic> toJson() => _gachaManager.toJson();
  void loadFromJson(Map<String, dynamic> json) {
    _gachaManager.loadFromJson(json);
    notifyListeners();
  }
}
