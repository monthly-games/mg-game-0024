import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../raid_manager.dart';

class RaidGame extends FlameGame with TapDetector {
  final RaidManager raidManager;
  late SpriteComponent _boss;
  late SpriteComponent _background;
  late TextComponent _damageText;

  RaidGame(this.raidManager);

  @override
  Future<void> onLoad() async {
    // Load background
    _background = SpriteComponent()
      ..sprite = await loadSprite('bg_raid.png')
      ..size = size;
    add(_background);

    // Load boss
    _boss = SpriteComponent()
      ..sprite = await loadSprite('boss_void_dragon.png')
      ..size = Vector2(250, 250)
      ..position = size / 2
      ..anchor = Anchor.center;
    add(_boss);

    _damageText = TextComponent(
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
      position: Vector2(size.x / 2, size.y / 2 - 150),
      anchor: Anchor.center,
    );
    add(_damageText);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (raidManager.state == RaidState.active) {
      // Visual feedback
      _boss.scale = Vector2.all(0.9);

      // Play SFX (Example placeholder)
      // AudioController().playSfx('sfx_attack.wav');

      // Deal damage via manager
      raidManager.dealDamage(100);

      _damageText.text = 'Hit! -100';
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    _boss.scale = Vector2.all(1.0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (raidManager.state == RaidState.victory) {
      _boss.opacity = 0.5; // Visual cue for death
    }
  }
}
