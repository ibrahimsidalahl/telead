import '../../../../features/home/data/models/course_model.dart';

abstract class MyCoursesState  {
  const MyCoursesState();

  @override
  List<Object?> get props => [];
}

class MyCoursesInitial extends MyCoursesState {}

class MyCoursesLoading extends MyCoursesState {}

class MyCoursesLoaded extends MyCoursesState {
  final List<CourseModel> courses;

  const MyCoursesLoaded(this.courses);

  @override
  List<Object?> get props => [courses];
}

class MyCoursesError extends MyCoursesState {
  final String message;

  const MyCoursesError(this.message);

  @override
  List<Object?> get props => [message];
}
