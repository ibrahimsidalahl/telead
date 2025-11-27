// bookmark_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/firebase_services/book_mark_services.dart';
import '../../../home/data/models/course_model.dart';
import 'book_mark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final BookMarkServices _BookMarkServices;
  final List<String> bookmarkedPaths;

  BookmarkCubit(this._BookMarkServices, this.bookmarkedPaths)
      : super(BookmarkInitial());

  Future<void> fetchBookmarkedCourses() async {
    emit(BookmarkLoading());

    try {
      final futures = bookmarkedPaths.map((path) {
        return _BookMarkServices.fetchCourseByPath(path);
      });

      final results = await Future.wait(futures);

      final validCourses = results.whereType<CourseModel>().toList();

      emit(BookmarkLoaded(validCourses));
    } catch (e) {
      emit(BookmarkError("حدث خطأ أثناء تحميل الكورسات المحفوظة"));
    }
  }

  Future<void> toggleBookmark(String coursePath) async {
    try {
      if (bookmarkedPaths.contains(coursePath)) {
        await _BookMarkServices.removeBookmark(coursePath);
        bookmarkedPaths.remove(coursePath);
      } else {
        await _BookMarkServices.addBookmark(coursePath);
        bookmarkedPaths.add(coursePath);
      }

      // إعادة تحميل الكورسات المحفوظة بعد التعديل
      await fetchBookmarkedCourses();
    } catch (e) {
      emit(BookmarkError("حدث خطأ أثناء تعديل المفضلة"));
    }
  }

}
