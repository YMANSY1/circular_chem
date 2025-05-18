import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/models/category_enum.dart';
import '../../../core/widgets/category_dropdown.dart'; // Import the CategoryDropdown widget

class ChangeIndustryDialog extends StatefulWidget {
  final CategoryType currentCategory;
  final Function onUpdateSuccess;

  const ChangeIndustryDialog({
    Key? key,
    required this.currentCategory,
    required this.onUpdateSuccess,
  }) : super(key: key);

  @override
  State<ChangeIndustryDialog> createState() => _ChangeIndustryDialogState();
}

class _ChangeIndustryDialogState extends State<ChangeIndustryDialog> {
  final _formKey = GlobalKey<FormState>();
  CategoryType? _newCategory;

  @override
  void initState() {
    super.initState();
    _newCategory = widget.currentCategory;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Category'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align labels to the start
          children: [
            const Text(
              'Current Category:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              // Display the current category name
              widget.currentCategory.name,
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(height: 16),
            const Text(
              'New Category:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CategoryDropdown(
              // Use the CategoryDropdown widget
              width: MediaQuery.of(context).size.width, // Make it responsive
              selected: _newCategory,
              onChanged: (CategoryType? newValue) {
                if (newValue != null) {
                  setState(() {
                    _newCategory = newValue;
                  });
                }
              },
              labelText: "Industry",
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
            if (_formKey.currentState!.validate() &&
                _newCategory != null &&
                _newCategory != widget.currentCategory) {
              // Only update if a new category is selected and it's different
              try {
                //showDialog to show loading.
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    });
                await AuthService(FirebaseAuth.instance).editUserInformation(
                  context,
                  'industry', // Use the correct field name in Firestore
                  _newCategory!.name, // Store the enum name, or its value
                );
                //pop loading dialog
                Navigator.of(context).pop();
                widget.onUpdateSuccess(); // Pass the new category
                // Navigator.of(context).pop(); // Close the dialog
              } catch (error) {
                // Show error message
                Navigator.of(context).pop(); //pop loading dialog.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to update category: $error'),
                  ),
                );
              }
            } else if (_newCategory == widget.currentCategory) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Please select a category different from the current category.'),
                  backgroundColor: Colors.yellow,
                ),
              );
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
