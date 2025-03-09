import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String title;
  String image_url;

  CategoryModel({
    required this.id,
    required this.title,
    required this.image_url,
  });

  static CategoryModel empty() => CategoryModel(
        id: '',
        title: '',
        image_url: '',
      );

  // Convert CategoryModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': image_url,
    };
  }

  factory CategoryModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        title: data['title'] ?? '',
        image_url: data['image_url'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
