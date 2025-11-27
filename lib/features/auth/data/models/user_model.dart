import '../../domain/entities/user_entity.dart';
import 'joined_courses_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.firstName,
    required super.secondName,
    required super.phone,
    required super.joinedCourses,
    required super.bookMarks,
    required super.userImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      joinedCourses: (json['JoinedCourses'] as List<dynamic>?)
          ?.map((e) => JoinedCoursesModel.fromJson(
        Map<String, dynamic>.from(e as Map),
      ))
          .toList(),
      bookMarks: (json['bookMark'] as List<dynamic>?)
          ?.map((e) => JoinedCoursesModel.fromJson(
        Map<String, dynamic>.from(e as Map),
      ))
          .toList(),
      firstName: json['first_name']?.toString() ?? '',
      secondName: json['second_name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      userImage: json['user_image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'JoinedCourses': joinedCourses?.map((e) => e.toJson()).toList() ?? [],
      'bookMark': bookMarks?.map((e) => e.toJson()).toList() ?? [],
      'first_name': firstName,
      'second_name': secondName,
      'email': email,
      'phone': phone,
      'user_image': userImage,
    };
  }
}
