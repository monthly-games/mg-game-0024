import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:mg_common_game/features/puzzle/logic/grid_manager.dart';
import 'package:mg_common_game/features/puzzle/logic/match_solver.dart';

class PuzzleGridComponent extends PositionComponent with TapCallbacks {
  final GridManager gridManager;
  final MatchSolver matchSolver;
  final double cellSize;

  // Selection state
  GridCell? _selectedCell;

  PuzzleGridComponent({
    required this.gridManager,
    required this.matchSolver,
    this.cellSize = 64.0,
    required Vector2 position,
  }) : super(
         position: position,
         size: Vector2(
           gridManager.width * cellSize,
           gridManager.height * cellSize,
         ),
       );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withAlpha(128)
      ..strokeWidth = 2.0;

    for (int y = 0; y < gridManager.height; y++) {
      for (int x = 0; x < gridManager.width; x++) {
        final cell = gridManager.getCell(x, y);
        final rect = Rect.fromLTWH(
          x * cellSize,
          y * cellSize,
          cellSize,
          cellSize,
        );

        // Draw Cell Background
        if ((x + y) % 2 == 0) {
          paint.color = Colors.grey[800]!;
        } else {
          paint.color = Colors.grey[700]!;
        }
        canvas.drawRect(rect, paint);

        // Draw Highlight if selected
        if (_selectedCell == cell) {
          paint.color = Colors.yellow.withAlpha(76);
          canvas.drawRect(rect, paint);
        }

        // Draw Content (Simple Color/Shape for now)
        if (!cell.isEmpty) {
          paint.color = _getColorForType(cell.type);
          canvas.drawCircle(rect.center, cellSize * 0.4, paint);
        }

        canvas.drawRect(rect, borderPaint);
      }
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'R':
        return Colors.red;
      case 'G':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'Y':
        return Colors.yellow;
      case 'P':
        return Colors.purple;
      default:
        return Colors.white;
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    final localPos = event.localPosition;
    final x = (localPos.x / cellSize).floor();
    final y = (localPos.y / cellSize).floor();

    if (x >= 0 && x < gridManager.width && y >= 0 && y < gridManager.height) {
      _handleCellTap(gridManager.getCell(x, y));
    }
  }

  void _handleCellTap(GridCell cell) {
    if (_selectedCell == null) {
      _selectedCell = cell;
    } else {
      final selected = _selectedCell!;
      // Check adjacency
      if (_isAdjacent(selected, cell)) {
        _swapAndCheck(selected, cell);
        _selectedCell = null;
      } else {
        // Deselect or select new
        if (selected == cell) {
          _selectedCell = null;
        } else {
          _selectedCell = cell;
        }
      }
    }
  }

  bool _isAdjacent(GridCell a, GridCell b) {
    final dx = (a.x - b.x).abs();
    final dy = (a.y - b.y).abs();
    return (dx + dy) == 1;
  }

  void _swapAndCheck(GridCell a, GridCell b) {
    gridManager.swap(a.x, a.y, b.x, b.y);

    // Check matches
    final matches = matchSolver.findMatches(gridManager);
    if (matches.isNotEmpty) {
      debugPrint('Matches found: ${matches.length}');
      // TODO: Handle matches (clear, score, etc)
      // For now, just clear them to show feedback
      for (final match in matches) {
        for (final cell in match.cells) {
          // We need to look up the cell in grid to clear it?
          // Objects are references, so:
          cell.clear();
        }
      }
    } else {
      // Swap back if no match (standard match-3 logic)
      // gridManager.swap(a.x, a.y, b.x, b.y);
      debugPrint('No match, swapped anyway for testing');
    }
  }
}
