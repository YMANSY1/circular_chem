import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:circular_chem_app/features/auth/widgets/account_settings_tile.dart';
import 'package:circular_chem_app/features/auth/widgets/user_info_card.dart';
import 'package:circular_chem_app/features/echo_points/screens/echo_points_leaderboard.dart';
import 'package:circular_chem_app/features/echo_points/screens/your_eco_points_screen.dart';
import 'package:circular_chem_app/features/marketplace/screens/user_items_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/account_settings_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<dynamic> _companyDataFuture;
  final AuthService _authService = AuthService(FirebaseAuth.instance);

  @override
  void initState() {
    super.initState();
    _refreshCompanyData();
  }

  // Function to refresh company data
  void _refreshCompanyData() {
    setState(() {
      _companyDataFuture =
          _authService.getCompanyData(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Account Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          FutureBuilder(
            future: _companyDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error finding company data.');
              } else if (snapshot.hasData) {
                final company = snapshot.data;
                if (company == null) {
                  return Column(
                    children: [
                      Text(
                          'Company data does not exist or could not be parsed.'),
                      _buildEcoPointsSection(
                          null), // Pass null when no company data
                    ],
                  );
                } else {
                  print(company.industry.name);
                  return Column(
                    children: [
                      AccountSettingsSection(
                        company: company,
                        onUpdateSuccess: _refreshCompanyData,
                      ),
                      _buildEcoPointsSection(company), // Pass company data
                    ],
                  );
                }
              } else {
                print(snapshot.data.toString());
                return Text('Unknown Error');
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Items',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SettingsCard(
            settingsTiles: <CardSettingsTile>[
              CardSettingsTile(
                label: 'View and Edit Your Posted Items!',
                iconColor: Colors.indigoAccent,
                icon: Icons.shopping_basket_rounded,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => UserItemsScreen()));
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEcoPointsSection(dynamic company) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8),
          child: Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Colors.amberAccent,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Eco Points',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.amberAccent),
              ),
            ],
          ),
        ),
        SettingsCard(
          settingsTiles: [
            CardSettingsTile(
              label: 'Eco Points Leaderboard',
              iconColor: Colors.amber[700]!,
              icon: Icons.leaderboard,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => EcoPointsLeaderboardScreen())),
            ),
            CardSettingsTile(
              label: 'Your Eco Points',
              iconColor: Colors.purple[600]!,
              icon: Icons.stars,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => YourEcoPointsScreen(company: company))),
            ),
          ],
        ),
      ],
    );
  }
}
