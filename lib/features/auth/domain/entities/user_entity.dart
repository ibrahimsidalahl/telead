import 'package:telead/features/auth/data/models/joined_courses_model.dart';

class UserEntity {
  final String email;
  final String firstName;
  final String secondName;
  final String phone;
  final String userImage;
  final List<JoinedCoursesModel>? joinedCourses;
  final List<JoinedCoursesModel>? bookMarks;

  UserEntity({
    required this.email,
    required this.firstName,
    required this.secondName,
    required this.phone,
    required this.userImage,
    required this.joinedCourses,
    required this.bookMarks,
  });
}
