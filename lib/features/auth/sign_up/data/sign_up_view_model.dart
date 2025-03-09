import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../bottom_navigation_bar/presentation/screens/bottom_navigation_bar_screen.dart';
import '../../../home/presentation/screens/teacher.dart';

class SignUpViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(BuildContext context, String firstName, String secondName,
      String email, String phone, String password, String role) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xff0961F5)),
        ),
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(email.trim()).set({
        'first_name': firstName.trim(),
        'second_name': secondName.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'role': role,
      });

      // Create user in Firebase Auth

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success!'),
          backgroundColor: Color(0xff0961F5),
        ),
      );

      // Navigate based on role
      if (role == 'Student') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BottomNavigationBarScreen(user_id: email.trim()),
          ),
        );
      } else if (role == 'Teacher') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Teacher()),
        );
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(context, e);
    } catch (e) {
      _handleGenericError(context, e);
    } finally {
      // Dismiss loading dialog
      Navigator.of(context).pop();
    }
  }

  void _handleFirebaseAuthError(BuildContext context, FirebaseAuthException e) {
    String errorMessage = 'An unexpected error occurred.';

    if (e.code == 'weak-password') {
      errorMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'The account already exists for that email.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Color(0xff0961F5),
      ),
    );
  }

  void _handleGenericError(BuildContext context, dynamic e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${e.toString()}'),
        backgroundColor: Color(0xff0961F5),
      ),
    );
  }
}