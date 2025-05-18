import 'package:flutter/material.dart';

import '../models/category_enum.dart';

class CategoryDropdown extends StatelessWidget {
  final double width;
  final CategoryType? selected;
  final ValueChanged<CategoryType?> onChanged;
  final String labelText;

  const CategoryDropdown({
    Key? key,
    required this.width,
    this.selected,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              labelText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.23),
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DropdownMenu<CategoryType>(
              initialSelection: selected,
              onSelected: onChanged,
              hintText: 'Select Industry',
              leadingIcon: Icon(Icons.factory_rounded),
              dropdownMenuEntries: CategoryType.values
                  .map((category) => DropdownMenuEntry<CategoryType>(
                        value: category,
                        label: category.name,
                      ))
                  .toList(),
              width: width - 24,
              menuStyle: MenuStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 12)),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                hintStyle: TextStyle(color: Colors.grey), // Style hint here!
              ),
            ),
          ),
        ],
      ),
    );
  }
}
