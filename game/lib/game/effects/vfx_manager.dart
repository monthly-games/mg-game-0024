/// VFX Manager for MG-0024 Legend Festival (Raid RPG)
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
      FlameParticleEffect(
        position: position.clone(),
        color: heroColor,
        particleCount: 15,
        duration: 0.4,
        spreadRadius: 30.0,
      ),
    );
  }

  /// Show raid boss damage effect
  void showBossDamage(Vector2 position) {
    _addEffect(
      FlameParticleEffect(
        position: position.clone(),
        color: Colors.red,
        particleCount: 25,
        duration: 0.6,
        spreadRadius: 45.0,
      ),
    );
  }

  /// Show skill activation effect
  void showSkillActivation(Vector2 position) {
    _addEffect(
      FlameParticleEffect(
        position: position.clone(),
        color: Colors.purple,
        particleCount: 20,
        duration: 0.5,
        spreadRadius: 40.0,
      ),
    );
  }

  /// Show loot drop effect
  void showLootDrop(Vector2 position) {
    _addEffect(
      FlameParticleEffect(
        position: position.clone(),
        color: Colors.amber,
        particleCount: 18,
        duration: 0.5,
        spreadRadius: 35.0,
      ),
    );
  }

  /// Show raid victory celebration
  void showRaidVictory(Vector2 position) {
    _addEffect(
      FlameParticleEffect(
        position: position.clone(),
        color: Colors.yellow,
        particleCount: 50,
        duration: 1.2,
        spreadRadius: 70.0,
      ),
    );
  }

  /// Show team combo effect
  void showTeamCombo(Vector2 position) {
    _addEffect(
      FlameParticleEffect(
        position: position.clone(),
        color: Colors.cyan,
        particleCount: 30,
        duration: 0.7,
        spreadRadius: 50.0,
      ),
    );
  }

  /// Show season reward effect
  void showSeasonReward(Vector2 position) {
    _addEffect(
      FlameParticleEffect(
        position: position.clone(),
        color: Colors.deepPurple,
        particleCount: 35,
        duration: 0.9,
        spreadRadius: 55.0,
      ),
    );
  }
}
