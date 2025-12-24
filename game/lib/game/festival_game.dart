import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mg_common_game/core/audio/audio_manager.dart';
import 'package:mg_common_game/core/ui/theme/app_colors.dart';
import 'package:mg_common_game/features/puzzle/logic/grid_manager.dart';
import 'package:mg_common_game/features/puzzle/logic/match_solver.dart';
import '../features/puzzle/components/puzzle_grid_component.dart';

class FestivalGame extends FlameGame {
  final AudioManager audio = GetIt.I<AudioManager>();
  late GridManager gridManager;
  late MatchSolver matchSolver;

  @override
  Color backgroundColor() => AppColors.background;

  @override
  Future<void> onLoad() async {
    // 1. Initialize Logic
    gridManager = GridManager(width: 6, height: 8);
    matchSolver = MatchSolver();

    // 2. Random Match-3 Board Generation (Simple)
    _fillRandomly();

    // 3. Add Component
    add(
      PuzzleGridComponent(
        gridManager: gridManager,
        matchSolver: matchSolver,
        position: Vector2(40, 100), // Padding
        cellSize: 50,
      ),
    );
  }

  void _fillRandomly() {
    final types = ['R', 'G', 'B', 'Y', 'P'];
    final random = Random();

    for (int y = 0; y < gridManager.height; y++) {
      for (int x = 0; x < gridManager.width; x++) {
        final cell = gridManager.getCell(x, y);
        cell.type = types[random.nextInt(types.length)];
        cell.isEmpty = false;
      }
    }
  }
}
