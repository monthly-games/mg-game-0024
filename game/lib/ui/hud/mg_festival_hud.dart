import 'package:flutter/material.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';
import 'package:mg_common_game/core/ui/layout/mg_spacing.dart';
import 'package:mg_common_game/core/ui/typography/mg_text_styles.dart';
import 'package:mg_common_game/core/ui/widgets/buttons/mg_icon_button.dart';
import 'package:mg_common_game/core/ui/widgets/progress/mg_linear_progress.dart';
import 'package:mg_common_game/core/ui/widgets/indicators/mg_resource_bar.dart';

/// MG-0024 Legend Festival Raid HUD
/// 페스티벌 레이드 게임용 HUD - 팀 정보, 보스 HP, 점수, 시즌 정보 표시
class MGFestivalHud extends StatelessWidget {
  final int gold;
  final int gems;
  final int festivalPoints;
  final int teamPower;
  final int bossHp;
  final int bossMaxHp;
  final String bossName;
  final int? raidTimeRemaining;
  final int? seasonDaysLeft;
  final String? seasonName;
  final VoidCallback? onPause;
  final VoidCallback? onTeam;

  const MGFestivalHud({
    super.key,
    required this.gold,
    required this.gems,
    required this.festivalPoints,
    required this.teamPower,
    required this.bossHp,
    required this.bossMaxHp,
    required this.bossName,
    this.raidTimeRemaining,
    this.seasonDaysLeft,
    this.seasonName,
    this.onPause,
    this.onTeam,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(MGSpacing.sm),
        child: Column(
          children: [
            // 상단 HUD
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 왼쪽: 시즌 정보
                if (seasonName != null) _buildSeasonInfo(),
                const Spacer(),
                // 오른쪽: 자원 & 버튼
                MGResourceBar(
                  resources: [
                    ResourceItem(
                      icon: Icons.monetization_on,
                      value: gold,
                      color: MGColors.resourceGold,
                    ),
                    ResourceItem(
                      icon: Icons.diamond,
                      value: gems,
                      color: MGColors.resourceGem,
                    ),
                    ResourceItem(
                      icon: Icons.celebration,
                      value: festivalPoints,
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
                SizedBox(width: MGSpacing.sm),
                if (onPause != null)
                  MGIconButton(
                    icon: Icons.pause,
                    onPressed: onPause!,
                    size: MGIconButtonSize.small,
                  ),
              ],
            ),
            SizedBox(height: MGSpacing.sm),
            // 팀 정보
            _buildTeamInfo(),
            const Spacer(),
            // 하단: 보스 정보
            _buildBossPanel(),
            // 레이드 타이머
            if (raidTimeRemaining != null) ...[
              SizedBox(height: MGSpacing.sm),
              _buildRaidTimer(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonInfo() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MGSpacing.sm,
        vertical: MGSpacing.xs,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.withOpacity(0.8),
            Colors.purple.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(MGSpacing.sm),
        border: Border.all(color: Colors.pinkAccent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.celebration, color: Colors.white, size: 18),
          SizedBox(width: MGSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                seasonName!,
                style: MGTextStyles.buttonSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (seasonDaysLeft != null)
                Text(
                  '$seasonDaysLeft days left',
                  style: MGTextStyles.caption.copyWith(
                    color: Colors.white70,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo() {
    return GestureDetector(
      onTap: onTeam,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MGSpacing.sm,
          vertical: MGSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: MGColors.surface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(MGSpacing.xs),
          border: Border.all(color: MGColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.group, color: Colors.cyan, size: 18),
            SizedBox(width: MGSpacing.xs),
            Text(
              'Team Power: ',
              style: MGTextStyles.caption.copyWith(
                color: Colors.white70,
              ),
            ),
            Text(
              _formatNumber(teamPower),
              style: MGTextStyles.buttonMedium.copyWith(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (onTeam != null) ...[
              SizedBox(width: MGSpacing.xs),
              Icon(Icons.edit, color: Colors.white54, size: 14),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBossPanel() {
    final double hpRatio = bossMaxHp > 0 ? bossHp / bossMaxHp : 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(MGSpacing.sm),
      decoration: BoxDecoration(
        color: MGColors.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(MGSpacing.sm),
        border: Border.all(color: Colors.red.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 보스 이름
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.whatshot, color: Colors.red, size: 20),
              SizedBox(width: MGSpacing.xs),
              Text(
                bossName,
                style: MGTextStyles.h3.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: MGSpacing.sm),
          // HP 바
          MGLinearProgress(
            value: hpRatio,
            height: 20,
            backgroundColor: Colors.red.withOpacity(0.2),
            progressColor: Colors.red,
          ),
          SizedBox(height: MGSpacing.xs),
          // HP 수치
          Text(
            '${_formatNumber(bossHp)} / ${_formatNumber(bossMaxHp)}',
            style: MGTextStyles.buttonMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRaidTimer() {
    final int minutes = raidTimeRemaining! ~/ 60;
    final int seconds = raidTimeRemaining! % 60;
    final bool isLowTime = raidTimeRemaining! < 30;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MGSpacing.md,
        vertical: MGSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isLowTime
            ? Colors.red.withOpacity(0.8)
            : Colors.orange.withOpacity(0.8),
        borderRadius: BorderRadius.circular(MGSpacing.sm),
        border: Border.all(
          color: isLowTime ? Colors.redAccent : Colors.orangeAccent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(width: MGSpacing.xs),
          Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: MGTextStyles.h3.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toString();
  }
}
