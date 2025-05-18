import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/auth_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _currentPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final isCurrentObscured = true.obs;
    final isNewObscured = true.obs;
    final isConfirmObscured = true.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Obx(() {
                return AuthField(
                  controller: _currentPasswordController,
                  labelText: 'Current Password',
                  obscureText: isCurrentObscured.value,
                  postfixIcon: IconButton(
                    icon: Icon(isCurrentObscured.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () =>
                        isCurrentObscured.value = !isCurrentObscured.value,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  // Added color
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                return AuthField(
                  controller: _newPasswordController,
                  labelText: 'New Password',
                  prefixIcon: const Icon(
                    Icons.lock_reset,
                    color: Colors.blue,
                  ),
                  obscureText: isNewObscured.value,
                  postfixIcon: IconButton(
                    icon: Icon(isNewObscured.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => isNewObscured.value = !isNewObscured.value,
                  ),
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (value == _currentPasswordController.text) {
                      return 'Please choose a unique password';
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                return AuthField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  obscureText: isConfirmObscured.value,
                  postfixIcon: IconButton(
                    icon: Icon(isConfirmObscured.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () =>
                        isConfirmObscured.value = !isConfirmObscured.value,
                  ),
                  validation: (value) {
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Trigger change password logic
                    print('Valid form, proceed to change password');
                    AuthService(FirebaseAuth.instance).changePassword(
                        context,
                        _currentPasswordController.text,
                        _newPasswordController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  //Styled the button
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blueAccent,
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
