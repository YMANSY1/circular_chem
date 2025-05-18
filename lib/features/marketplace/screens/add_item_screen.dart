import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:circular_chem_app/features/marketplace/models/item.dart';
import 'package:circular_chem_app/features/marketplace/services/marketplace_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/category_enum.dart';
import '../../../core/widgets/category_dropdown.dart';
import '../widgets/add_item_button.dart';
import '../widgets/add_item_field.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  CategoryType? selectedCategory;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  final isTextVisible = false.obs;

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? _priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    if (double.tryParse(value) == null) {
      return 'Invalid price format';
    }
    return null;
  }

  String? _imageUrlValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an image URL';
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select your item type')));
        return;
      }
      String name = _nameController.text;
      double price = double.parse(_priceController.text);
      String imageUrl = _imageUrlController.text;
      final quantity = int.parse(_quantityController.text);
      final description = _descriptionController.text;
      final firebaseAuth = FirebaseAuth.instance;
      final company = await AuthService(firebaseAuth)
          .getCompanyData(firebaseAuth.currentUser!.uid);
      if (company == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Couldn\'t fetch data')));
        return;
      }
      final item = Item(
          name: name,
          sellingCompany: company,
          category: selectedCategory!,
          imageUrl: imageUrl.isEmpty ? null : imageUrl,
          description: description,
          price: price,
          quantity: quantity);
      await MarketplaceService(FirebaseFirestore.instance).uploadItem(item);

      isTextVisible.value = !isTextVisible.value;

      // Reset the form controls
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _imageUrlController.clear();
      _quantityController.clear();

      // Force rebuild with null category - this is key to reset the dropdown
      setState(() {
        selectedCategory = null;
      });

      // Reset the form state AFTER clearing the values
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add an Item!')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AddItemField(
                prefixIcon: const Icon(Icons.business),
                labelText: 'Name',
                hintText: 'Enter item name',
                controller: _nameController,
                validation: _nameValidator,
              ),
              // Use a key to force rebuild when selectedCategory changes
              CategoryDropdown(
                key: ValueKey(selectedCategory),
                width: double.infinity,
                onChanged: (s) {
                  if (s != null) {
                    setState(() {
                      selectedCategory = s;
                    });
                  }
                },
                labelText: 'Type',
                selected: selectedCategory,
              ),
              Row(
                children: [
                  Expanded(
                    child: AddItemField(
                      prefixIcon: const Icon(Icons.attach_money),
                      labelText: 'Price',
                      hintText: 'Enter price',
                      controller: _priceController,
                      validation: _priceValidator,
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Add some spacing between the fields
                  Expanded(
                    child: AddItemField(
                      prefixIcon: const Icon(Icons.numbers),
                      labelText: 'Quantity',
                      hintText: 'Enter quantity',
                      controller: _quantityController,
                      validation: _priceValidator,
                    ),
                  ),
                ],
              ),
              AddItemField(
                prefixIcon: const Icon(Icons.image),
                labelText: 'Image URL',
                hintText: 'Enter image URL',
                controller: _imageUrlController,
                validation: _imageUrlValidator,
              ),
              AddItemField(
                controller: _descriptionController,
                labelText: 'Description (Optional)',
                prefixIcon: Icon(Icons.description),
                hintText: 'Write a description',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              AddItemButton(
                onPressed: _submitForm,
              ),
              const SizedBox(height: 20),
              isTextVisible.value
                  ? Text(
                      'Success! Your item posting has been submitted to the CircularChem team for review and echo point assignment. You can expect it to go live within approximately 2 days. If any issues arise, we’ll contact you by email to resolve them promptly. Thank you for contributing to a more sustainable future!',
                      style: const TextStyle(
                        color: Colors.green,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
