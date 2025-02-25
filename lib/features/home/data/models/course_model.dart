import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telead/features/home/data/models/rating_model.dart';

class CourseModel {
  String id;
  String title;
  String imageUrl;
  String categoryId;
  String description;
  int price;
  String instructorId;
  List<String> studentEnrolled;
  List<Rating> rating;

  CourseModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
    required this.description,
    required this.instructorId,
    required this.studentEnrolled,
    required this.rating,
  });

  static CourseModel empty() => CourseModel(
    id: '',
    title: '',
    imageUrl: '',
    price: 0,
    categoryId: '',
    description: '',
    instructorId: '',
    studentEnrolled: [],
    rating: [],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_Url': imageUrl,
      'price': price,
      'instructor_Id': instructorId,
      'description': description,
      'category_Id': categoryId,
      'student_Enrolled': studentEnrolled,
      'rating': rating.map((r) => r.toJson()).toList(), // Convert Rating objects to JSON
    };
  }

  // بناء CourseModel من JSON
  factory CourseModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CourseModel(
        id: document.id,
        title: data['title'] ?? '',
        imageUrl: data['image_Url'] ?? '',
        price: data['price'] ?? 0,
        categoryId: data['category_Id'] ?? '',
        description: data['description'] ?? '',
        instructorId: data['instructor_Id'] ?? '',
        studentEnrolled: data['student_Enrolled'] != null
            ? List<String>.from(data['student_Enrolled'])
            : [],
        rating: data['rating'] != null
            ? (data['rating'] as List<dynamic>).map((r) => Rating.fromJson(r)).toList()
            : [],
      );
    } else {
      return CourseModel.empty();
    }
  }
}

