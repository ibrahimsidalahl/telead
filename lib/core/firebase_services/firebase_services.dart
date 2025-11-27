import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/auth/data/models/user_model.dart';
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

  Future<List<CourseModel>> fetchCategoryDetails(String id) async {
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





}
