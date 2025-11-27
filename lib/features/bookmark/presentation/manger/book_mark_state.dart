import '../../../home/data/models/course_model.dart';

abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<CourseModel> courses;

  BookmarkLoaded(this.courses);
}

class BookmarkError extends BookmarkState {
  final String message;

  BookmarkError(this.message);
}
