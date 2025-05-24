import 'package:circular_chem_app/core/screens/main_page.dart';
import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../features/auth/screens/auth_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService(FirebaseAuth.instance).authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainPage();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
