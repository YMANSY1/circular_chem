import 'package:circular_chem_app/core/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = FirebaseAuth.instanceFor(app: app);
  runApp(CircularChemApp());
}

class CircularChemApp extends StatelessWidget {
  const CircularChemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: WidgetTree(),
      debugShowCheckedModeBanner: false,
    );
  }
}
