import 'package:mg_common_game/core/ui/layout/mg_spacing.dart';
import 'package:mg_common_game/core/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/social/social_manager.dart';
import 'package:mg_common_game/core/ui/theme/mg_colors.dart';import 'package:mg_common_game/l10n/localization.dart';


class GuildScreen extends StatefulWidget {
  const GuildScreen({super.key});

  @override
  State<GuildScreen> createState() => _GuildScreenState();
}

class _GuildScreenState extends State<GuildScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<SocialManager>();
    final guild = manager.currentGuild;

    if (guild == null) {
      return Scaffold(
        appBar: AppBar(title: Text('ui_general_guild_center'.tr)),
        body: Padding(
          padding: const EdgeInsets.all(MGSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create a Guild',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: MGSpacing.md),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Guild Name'),
              ),
              const SizedBox(height: MGSpacing.xs),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: MGSpacing.lg),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    manager.createGuild(
                      _nameController.text,
                      _descController.text,
                    );
                  }
                },
                child: Text('ui_general_create_guild'.tr),
              ),
              const Divider(height: 32),
              Center(child: Text('ui_general_join_feature_coming_soon_simulated'.tr)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(guild.name)),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(MGSpacing.md),
            color: Colors.indigo.shade900,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level ${guild.level}',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  guild.description,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: guild.members.length,
              itemBuilder: (context, index) {
                final member = guild.members[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(member.name),
                  subtitle: Text(member.role),
                  trailing: member.isOnline
                      ? const Icon(Icons.circle, color: MGColors.success, size: 12)
                      : const Icon(Icons.circle, color: MGColors.common, size: 12),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(MGSpacing.md),
            child: ElevatedButton(
              onPressed: () => manager.leaveGuild(),
              style: ElevatedButton.styleFrom(backgroundColor: MGColors.error),
              child: const Text(
                'Leave Guild',
                style: TextStyle(color: MGColors.textHighEmphasis),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
