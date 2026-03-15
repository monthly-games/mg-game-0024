/// VFX Manager for MG-0024 Legend Festival (Raid RPG)
library;
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mg_common_game/core/engine/effects/flame_effects.dart';

class VfxManager extends Component {
  VfxManager();

  Component? _gameRef;

  void setGame(Component game) {
    _gameRef = game;
  }

  void _addEffect(Component effect) {
    _gameRef?.add(effect);
  }

  /// Show hero attack effect
  void showHeroAttack(Vector2 position, Color heroColor) {
    _addEffect(
      FlameParticleEffect.explosion(
          position: position.clone(),
          color: heroColor,
          radius: 30.0,
        ),
    );
  }

  /// Show raid boss damage effect
  void showBossDamage(Vector2 position) {
    _addEffect(
      FlameParticleEffect.explosion(
          position: position.clone(),
          color: Colors.red,
          radius: 45.0,
        ),
    );
  }

  /// Show skill activation effect
  void showSkillActivation(Vector2 position) {
    _addEffect(
      FlameParticleEffect.explosion(
          position: position.clone(),
          color: Colors.purple,
          radius: 40.0,
        ),
    );
  }

  /// Show loot drop effect
  void showLootDrop(Vector2 position) {
    _addEffect(
      FlameParticleEffect.explosion(
          position: position.clone(),
          color: Colors.amber,
          radius: 35.0,
        ),
    );
  }

  /// Show raid victory celebration
  void showRaidVictory(Vector2 position) {
    _addEffect(
      FlameParticleEffect.explosion(
          position: position.clone(),
          color: Colors.yellow,
          radius: 70.0,
        ),
    );
  }

  /// Show team combo effect
  void showTeamCombo(Vector2 position) {
    _addEffect(
      FlameParticleEffect.explosion(
          position: position.clone(),
          color: Colors.cyan,
          radius: 50.0,
        ),
    );
  }

  /// Show season reward effect
  void showSeasonReward(Vector2 position) {
    _addEffect(
      FlameParticleEffect.explosion(
          position: position.clone(),
          color: Colors.deepPurple,
          radius: 55.0,
        ),
    );
  }
}
