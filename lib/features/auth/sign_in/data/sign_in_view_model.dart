import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../bottom_navigation_bar/presentation/screens/bottom_navigation_bar_screen.dart';
import '../../../home/presentation/screens/teacher.dart';
import '../presentation/screens/sign_in_screen.dart';

class SignInViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xff0961F5)),
        ),
      );
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(email.trim()).get();

      if (userDoc.exists) {
        String role = userDoc['role'];

        // Clear text controllers
        SignInScreen.emailController.clear();
        SignInScreen.passwordController.clear();

        // Navigate based on role
        if (role == 'Student') {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigationBarScreen(
                user_id: email.trim(),
              ),
            ),
          );
        } else if (role == 'Teacher') {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Teacher()),
          );
        }

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Success!'),
            backgroundColor: Color(0xff0961F5),
          ),
        );
      } else {
        Navigator.of(context).pop(); // إغلاق dialog في حالة الخطأ
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.red,
              content: Text('User document not found!')),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      _handleFirebaseAuthError(context, e);
    } catch (e) {
      Navigator.of(context).pop();
      _handleGenericError(context, e);
    }
  }

  void _handleFirebaseAuthError(BuildContext context, FirebaseAuthException e) {
    String errorMessage = 'An error occurred. Please try again.';

    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided.';
    } else if (e.code == 'invalid-credential') {
      errorMessage = 'Invalid credential. Please try again.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red,

          content: Text(errorMessage)),
    );
  }

  void _handleGenericError(BuildContext context, dynamic e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred: ${e.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
