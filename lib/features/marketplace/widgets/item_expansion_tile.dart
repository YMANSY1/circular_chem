import 'package:flutter/material.dart';

import 'custom_list_tile.dart'; // Assuming CustomListTile is defined here

class ItemExpansionTile extends StatelessWidget {
  const ItemExpansionTile({
    super.key,
    this.leading, // Now takes a Widget for the leading part of ExpansionTile
    required this.title, // Now takes a Widget for the title of ExpansionTile
    this.subtitle, // Now takes a Widget for the subtitle of ExpansionTile
    required this.detailTiles, // Takes a list of CustomListTile for the content
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final List<CustomListTile> detailTiles; // The list of CustomListTile widgets

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: detailTiles, // Use the provided list of CustomListTile
          ),
        ),
      ],
    );
  }
}
