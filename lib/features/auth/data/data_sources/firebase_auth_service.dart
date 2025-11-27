import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sign Up
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
    required String secondName,
    required String phone,
    String? jobTitle,
    String? userImage,
  }) async {
    // 1. Firebase Auth
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    // 2. Create UserModel
    final userModel = UserModel(
      email: email,
      firstName: firstName,
      secondName: secondName,
      phone: phone,
      userImage: userImage ?? 'https://firebasestorage.googleapis.com/v0/b/telead-ad2b0.appspot.com/o/users%2Fperson_logo.png?alt=media&token=234cee3d-14c7-403c-aa01-15e6a9df9594',
      joinedCourses: [],
      bookMarks: [],
    );

    // 3. Save in Firestore
    await _firestore.collection("users").doc(uid).set(userModel.toJson());

    return userModel;
  }

  /// Sign In
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    // Fetch user data from Firestore
    final snapshot = await _firestore.collection("users").doc(uid).get();

    if (!snapshot.exists) {
      throw Exception("User data not found in Firestore.");
    }

    return UserModel.fromJson(snapshot.data()!);
  }
  /// Get user data

  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    final snapshot =
    await _firestore.collection("users").doc(firebaseUser.uid).get();

    if (!snapshot.exists) return null;

    return UserModel.fromJson(snapshot.data()!);
  }

  Future<void> signOut() async => await _auth.signOut();
}
