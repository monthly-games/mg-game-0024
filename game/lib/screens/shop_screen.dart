import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/meta/economy_manager.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final economy = context.watch<EconomyManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Shop'),
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
        padding: const EdgeInsets.all(16),
        children: [
          _ShopItem(
            name: 'Energy Potion',
            cost: 100,
            icon: Icons.flash_on,
            onBuy: () {
              if (context.read<EconomyManager>().spendCoins(100)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Purchased Energy Potion!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Not enough coins!')),
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
                  const SnackBar(content: Text('Purchased Raid Ticket!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Not enough coins!')),
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
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('$cost Coins', style: const TextStyle(color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}
