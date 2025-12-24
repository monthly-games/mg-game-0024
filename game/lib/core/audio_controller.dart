import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class AudioController {
  static final AudioController _instance = AudioController._internal();
  factory AudioController() => _instance;
  AudioController._internal();

  bool _isBgmPlaying = false;

  Future<void> initialize() async {
    // flame_audio doesn't strictly need init, but we can pre-load if needed
    // await FlameAudio.audioCache.loadAll(['bgm_raid.mp3', 'sfx_attack.wav']);
  }

  void playBgm(String filename) {
    if (kIsWeb) return; // Simple safeguard for now

    try {
      if (!_isBgmPlaying) {
        FlameAudio.bgm.play(filename);
        _isBgmPlaying = true;
      }
    } catch (e) {
      debugPrint('Error playing BGM: $e');
    }
  }

  void stopBgm() {
    try {
      if (_isBgmPlaying) {
        FlameAudio.bgm.stop();
        _isBgmPlaying = false;
      }
    } catch (e) {
      debugPrint('Error stopping BGM: $e');
    }
  }

  void playSfx(String filename) {
    try {
      FlameAudio.play(filename);
    } catch (e) {
      debugPrint('Error playing SFX: $e');
    }
  }
}
