import 'package:flutter/material.dart';

class CardSettingsTile extends StatelessWidget {
  const CardSettingsTile({
    super.key,
    this.data,
    required this.label,
    required this.iconColor,
    this.showEdit = true,
    required this.icon,
    this.onPressed,
    this.onIconButtonPressed,
  });

  final String? data;
  final String label;
  final Color iconColor;
  final bool showEdit;
  final IconData icon;
  final VoidCallback? onPressed;
  final VoidCallback? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(label),
      subtitle: data != null
          ? Text(
              data!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black87),
            )
          : null,
      trailing: onPressed == null
          ? (showEdit
              ? InkWell(
                  onTap: onIconButtonPressed,
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.edit, size: 20, color: Colors.grey[700]),
                  ),
                )
              : null)
          : Icon(Icons.arrow_forward_ios_outlined,
              size: 20, color: Colors.grey[700]),
    );
  }
}
