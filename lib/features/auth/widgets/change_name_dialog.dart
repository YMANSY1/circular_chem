import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeFieldDialog extends StatefulWidget {
  final TextEditingController newValueController;
  final String currentValue;
  final String valueName;
  final String fieldName;
  final Function onUpdateSuccess;

  const ChangeFieldDialog({
    Key? key,
    required this.newValueController,
    required this.currentValue,
    required this.onUpdateSuccess,
    required this.valueName,
    required this.fieldName,
  }) : super(key: key);

  @override
  State<ChangeFieldDialog> createState() => _ChangeFieldDialogState();
}

class _ChangeFieldDialogState extends State<ChangeFieldDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change ${widget.valueName}'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.currentValue,
              decoration:
                  InputDecoration(labelText: 'Current ${widget.valueName}'),
              enabled: false,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: widget.newValueController,
              decoration: InputDecoration(labelText: 'New ${widget.valueName}'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a new ${widget.valueName.toLowerCase()}';
                }
                if (value.trim() == widget.currentValue.trim()) {
                  return 'New name must be different from the current ${widget.valueName.toLowerCase()}';
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
                widget.fieldName,
                widget.newValueController.text.trim(),
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
