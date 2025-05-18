import 'package:flutter/material.dart';

import 'account_settings_tile.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.settingsTiles,
  });

  final List<CardSettingsTile> settingsTiles;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          for (int i = 0; i < settingsTiles.length; i++) ...[
            settingsTiles[i],
            if (i < settingsTiles.length - 1)
              const Divider(height: 1), // Avoid divider after the last tile
          ]
        ],
      ),
    );
  }
}
