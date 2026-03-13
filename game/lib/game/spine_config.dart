import 'package:mg_common_game/core/assets/asset_types.dart';

/// Spine 통합 플래그. `--dart-define=SPINE_ENABLED=true`로 활성화.
const kSpineEnabled = bool.fromEnvironment(
  'SPINE_ENABLED',
  defaultValue: false,
);

// ── Festival Hero ────────────────────────────────────────────

const kFestivalHeroMeta = SpineAssetMeta(
  key: 'festival_hero',
  path: 'spine/characters/festival_hero',
  atlasPath:
      'assets/spine/characters/festival_hero/festival_hero.atlas',
  skeletonPath:
      'assets/spine/characters/festival_hero/festival_hero.skel',
  animations: ['idle', 'walk', 'attack', 'hit'],
  defaultAnimation: 'idle',
  defaultMix: 0.2,
);

// ── Festival Dancer ──────────────────────────────────────────

const kFestivalDancerMeta = SpineAssetMeta(
  key: 'festival_dancer',
  path: 'spine/characters/festival_dancer',
  atlasPath:
      'assets/spine/characters/festival_dancer/festival_dancer.atlas',
  skeletonPath:
      'assets/spine/characters/festival_dancer/festival_dancer.skel',
  animations: ['idle', 'walk', 'attack', 'hit'],
  defaultAnimation: 'idle',
  defaultMix: 0.2,
);

// ── Festival Bard ────────────────────────────────────────────

const kFestivalBardMeta = SpineAssetMeta(
  key: 'festival_bard',
  path: 'spine/characters/festival_bard',
  atlasPath:
      'assets/spine/characters/festival_bard/festival_bard.atlas',
  skeletonPath:
      'assets/spine/characters/festival_bard/festival_bard.skel',
  animations: ['idle', 'walk', 'attack', 'hit'],
  defaultAnimation: 'idle',
  defaultMix: 0.2,
);
