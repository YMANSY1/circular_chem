import 'package:circular_chem_app/features/auth/screens/change_password_screen.dart';
import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:circular_chem_app/features/auth/widgets/change_industry_dialog.dart';
import 'package:circular_chem_app/features/auth/widgets/change_name_dialog.dart';
import 'package:circular_chem_app/features/auth/widgets/profile_picture.dart';
import 'package:circular_chem_app/features/auth/widgets/user_info_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/models/company.dart';
import 'account_settings_tile.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({
    super.key,
    required this.company,
    required this.onUpdateSuccess, // Added refresh callback
  });

  final Company company;
  final VoidCallback onUpdateSuccess; // New callback property

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(FirebaseAuth.instance);

    return Column(children: [
      ProfilePicture(),
      const SizedBox(height: 20),
      SettingsCard(
        settingsTiles: [
          CardSettingsTile(
            icon: Icons.business,
            label: 'Company Name',
            data: company.companyName,
            iconColor: Colors.blue,
            showEdit: true,
            onIconButtonPressed: () {
              final TextEditingController controller = TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return ChangeNameDialog(
                    newNameController: controller,
                    currentName: company.companyName,
                    onUpdateSuccess: onUpdateSuccess, // Pass the callback
                  );
                },
              );
            },
          ),
          CardSettingsTile(
            icon: Icons.assignment,
            label: 'Tax Registration Number',
            data: company.taxRegistryNumber,
            iconColor: Colors.deepPurpleAccent,
            showEdit: false,
          ),
          CardSettingsTile(
            data: company.industry.name,
            label: 'Industry',
            iconColor: Colors.tealAccent,
            icon: Icons.factory,
            onIconButtonPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ChangeIndustryDialog(
                    currentCategory: company.industry,
                    onUpdateSuccess: onUpdateSuccess, // Pass the callback
                  );
                },
              );
            },
          ),
          CardSettingsTile(
            icon: Icons.email,
            label: 'Email',
            data: company.email,
            iconColor: Colors.green,
            showEdit: false,
          ),
          CardSettingsTile(
            icon: Icons.lock,
            label: 'Password',
            data: '••••••••',
            iconColor: Colors.orange,
            showEdit: true,
            onIconButtonPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ChangePasswordScreen())),
          ),
        ],
      ),
      const SizedBox(height: 24),
      ElevatedButton.icon(
        onPressed: () async {
          try {
            await authService.signOut();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error signing out: $e')),
            );
          }
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
          'LOGOUT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          minimumSize: const Size(200, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),
      const SizedBox(height: 16),
    ]);
  }
}
