import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/data/user_model.dart';
import '../../features/home/data/models/category_model.dart';
import '../../features/home/data/models/course_model.dart';

class FirebaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchAllCategories() async {
    List<CategoryModel> categoriesList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('categories').get();

      categoriesList = snapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc);
      }).toList();
    } catch (e) {
      print("Error fetching categories: $e");
    }

    return categoriesList;
  }

  Future<List<CourseModel>> fetchAllCourses(String id) async {
    List<CourseModel> coursesList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('/categories/$id/courses').get();

      coursesList = snapshot.docs.map((doc) {
        return CourseModel.fromJson(doc);
      }).toList();
    } catch (e) {
      print("Error fetching categories: $e");
    }

    return coursesList;
  }

  Future<List<CourseModel>> fetchCourseDetails(String id) async {
    List<CourseModel> coursesList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('/categories/3D Design/courses/$id').get();

      coursesList = snapshot.docs.map((doc) {
        return CourseModel.fromJson(doc);
      }).toList();
    } catch (e) {
      print("Error fetching categories: $e");
    }

    return coursesList;
  }
  Future<UserModel> getUserData(String id , ) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get();

      if (docSnapshot.exists) {
        return UserModel.fromJson(docSnapshot.data()!);
      } else {
        throw Exception("User with ID $id not found.");
      }
    } catch (e) {
      throw Exception("Error fetching user dataaaaaaaaaaaaaaaaaaaaaaa: $e");
    }
  }



}
