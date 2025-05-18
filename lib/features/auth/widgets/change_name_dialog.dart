import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeNameDialog extends StatefulWidget {
  final TextEditingController newNameController;
  final String currentName;
  final Function onUpdateSuccess;

  const ChangeNameDialog({
    Key? key,
    required this.newNameController,
    required this.currentName,
    required this.onUpdateSuccess,
  }) : super(key: key);

  @override
  State<ChangeNameDialog> createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Name'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.currentName,
              decoration: const InputDecoration(labelText: 'Current Name'),
              enabled: false,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: widget.newNameController,
              decoration: const InputDecoration(labelText: 'New Name'),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a new name';
                }
                if (value.trim() == widget.currentName.trim()) {
                  return 'New name must be different from the current name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await AuthService(FirebaseAuth.instance).editUserInformation(
                context,
                'company_name',
                widget.newNameController.text.trim(),
              );
              widget.onUpdateSuccess();
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
