import 'dart:async';

import 'package:circular_chem_app/core/models/company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:flutter/material.dart';

import '../../../core/models/category_enum.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;

  AuthService(this.firebaseAuth);

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  User? get user => firebaseAuth.currentUser;

  Future<User?> createAccount({
    required String email,
    required String password,
    required String companyName,
    required String taxRegistryNumber,
    required CategoryType industry,
  }) async {
    try {
      // Check if tax_no is already used
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('tax_no', isEqualTo: taxRegistryNumber)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        throw Exception('A company with this tax number already exists.');
      }

      // Create user in Firebase Auth
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'company_name': companyName,
          'email': email,
          'echo_points': 0,
          'tax_no': taxRegistryNumber,
          'industry': industry.name
        });
        return user;
      } else {
        if (kDebugMode) {
          print('User not created in Firebase Auth');
        }
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Exception: ${e.code} - ${e.message}');
      }
      if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is badly formatted.');
      } else if (e.code == 'weak-password') {
        throw Exception('The password is too weak.');
      } else {
        throw Exception('Failed to create account: ${e.message}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating account: $e');
      }
      throw Exception(
          'An unexpected error occurred while creating the account.');
    }
  }

  Future<User?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Exception: ${e.code} - ${e.message}');
      }
      // Handle specific Firebase Auth errors
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is badly formatted.');
      } else {
        throw Exception('Failed to log in: ${e.message}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error logging in: $e');
      }
      throw Exception('An unexpected error occurred while logging in.');
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<Company?> getCompanyData(String uid) async {
    try {
      final userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userData.exists) {
        final Map<String, dynamic>? companyMap = userData.data();
        if (companyMap != null) {
          return Company.fromMap(companyMap);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching company data: $e');
      return null;
    }
  }

  Future<void> changePassword(
      BuildContext context, String currentPassword, String newPassword) async {
    try {
      if (user == null) {
        throw Exception('User is not authenticated');
      }

      if (user!.email == null) {
        throw Exception('User does not have an email');
      }

      final cred = EmailAuthProvider.credential(
          email: user!.email!, password: currentPassword);

      await user!.reauthenticateWithCredential(cred);

      await user!.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully')));
      Navigator.pop(context);
    } catch (error) {
      String errorMessage = 'Error changing password';

      if (error.toString().contains('wrong-password')) {
        errorMessage = 'Current password is incorrect';
      } else if (error.toString().contains('requires-recent-login')) {
        errorMessage = 'Please log in again before changing your password';
      } else if (error.toString().contains('weak-password')) {
        errorMessage = 'New password is too weak';
      } else {
        errorMessage = 'Error changing password: ${error.toString()}';
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  Future<void> editUserInformation(
      BuildContext context, String fieldName, String newValue) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({fieldName: newValue});
      Navigator.pop(context);
    } catch (e) {
      print('Failed to update $fieldName: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error occurred when updating user information')));
    }
  }
}
