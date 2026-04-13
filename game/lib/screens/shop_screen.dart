import 'package:mg_common_game/core/ui/layout/mg_spacing.dart';
import 'package:mg_common_game/core/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/meta/economy_manager.dart';import 'package:mg_common_game/l10n/localization.dart';


class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final economy = context.watch<EconomyManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text('shop_festival_shop'.tr),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Coins: ${economy.festivalCoins}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(MGSpacing.md),
        children: [
          _ShopItem(
            name: 'Energy Potion',
            cost: 100,
            icon: Icons.flash_on,
            onBuy: () {
              if (context.read<EconomyManager>().spendCoins(100)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('shop_purchased_energy_potion'.tr)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ui_general_not_enough_coins'.tr)),
                );
              }
            },
          ),
          _ShopItem(
            name: 'Raid Ticket',
            cost: 500,
            icon: Icons.confirmation_number,
            onBuy: () {
              if (context.read<EconomyManager>().spendCoins(500)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('shop_purchased_raid_ticket'.tr)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ui_general_not_enough_coins'.tr)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ShopItem extends StatelessWidget {
  final String name;
  final int cost;
  final IconData icon;
  final VoidCallback onBuy;

  const _ShopItem({
    required this.name,
    required this.cost,
    required this.icon,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onBuy,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blueAccent),
            const SizedBox(height: MGSpacing.xs),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: MGSpacing.xxs),
            Text('$cost Coins', style: const TextStyle(color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}
