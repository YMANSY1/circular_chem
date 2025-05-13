import 'package:flutter/material.dart';

class AccountSettingsTile extends StatelessWidget {
  const AccountSettingsTile({
    super.key,
    required this.data,
    required this.label,
    required this.iconColor,
    this.showEdit = true,
    required this.icon,
  });

  final String data;
  final String label;
  final Color iconColor;
  final bool showEdit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(label),
      subtitle: Text(
        data,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black87),
      ),
      trailing:
          showEdit ? Icon(Icons.edit, size: 20, color: Colors.grey[700]) : null,
    );
  }
}
