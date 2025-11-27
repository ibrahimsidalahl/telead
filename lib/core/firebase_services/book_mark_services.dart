import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/data/models/course_model.dart';

class BookMarkServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String userId;

  BookMarkServices(this.userId);

  Future<CourseModel?> fetchCourseByPath(String coursePath) async {
    try {
      final doc = await firestore.doc(coursePath).get();
      if (doc.exists) {
        return CourseModel.fromJson(doc);
      }
    } catch (e) {
      print("Error fetching course at $coursePath: $e");
    }
    return null;
  }

  Future<void> addBookmark(String coursePath) async {
    try {
      final userRef = firestore.collection('users').doc(userId);
      await userRef.update({
        'bookMark': FieldValue.arrayUnion([coursePath])
      });
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  Future<void> removeBookmark(String coursePath) async {
    try {
      final userRef = firestore.collection('users').doc(userId);
      await userRef.update({
        'bookMark': FieldValue.arrayRemove([coursePath])
      });
    } catch (e) {
      print("Error removing bookmark: $e");
    }
  }
}
