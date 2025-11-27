import '../../../data/models/course_model.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  late final List<CourseModel> course;

  CourseLoaded(this.course);
}

class CourseError extends CourseState {
  final String message;

  CourseError(this.message);
}
