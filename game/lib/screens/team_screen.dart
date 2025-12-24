import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/team/team_manager.dart';
import '../core/models.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<TeamManager>();
    final team = manager.activeTeam;

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Team')),
      body: Column(
        children: [
          // Active Team Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blueGrey.shade900,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Team Power: ${team.totalPower.toInt()}',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (team.synergyMultiplier > 1.0)
                      Text(
                        'Synergy: +${((team.synergyMultiplier - 1) * 100).toInt()}%',
                        style: const TextStyle(color: Colors.greenAccent),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    if (index < team.members.length) {
                      return _HeroSlot(
                        hero: team.members[index],
                        onTap: () =>
                            manager.removeFromTeam(team.members[index]),
                      );
                    } else {
                      return const _EmptySlot();
                    }
                  }),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Colors.white24),

          // Roster Section
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: manager.roster.length,
              itemBuilder: (context, index) {
                final hero = manager.roster[index];
                final isSelected = manager.isInTeam(hero);

                return _RosterCard(
                  hero: hero,
                  isSelected: isSelected,
                  onTap: () {
                    if (isSelected) {
                      manager.removeFromTeam(hero);
                    } else {
                      manager.addToTeam(hero);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSlot extends StatelessWidget {
  final HeroCharacter hero;
  final VoidCallback onTap;

  const _HeroSlot({required this.hero, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            hero.name,
            style: const TextStyle(color: Colors.white, fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _EmptySlot extends StatelessWidget {
  const _EmptySlot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: const Icon(Icons.add, color: Colors.white24),
    );
  }
}

class _RosterCard extends StatelessWidget {
  final HeroCharacter hero;
  final bool isSelected;
  final VoidCallback onTap;

  const _RosterCard({
    required this.hero,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 0.5 : 1.0,
        child: Card(
          color: Colors.grey.shade800,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 32, color: Colors.white70),
                const SizedBox(height: 8),
                Text(
                  hero.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  hero.fromGame,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'pow: ${hero.power}',
                  style: const TextStyle(color: Colors.amber, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
