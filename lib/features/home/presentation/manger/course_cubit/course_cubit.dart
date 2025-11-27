import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/firebase_services/firebase_services.dart';
import '../../../data/models/course_model.dart';
import 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());

  final FirebaseServices _firebaseServices = FirebaseServices();

  Future<void> fetchCategories(String id) async {
    emit(CourseLoading());
    try {
      final List<CourseModel> course =
          await _firebaseServices.fetchCategoryDetails(id);
      if (course.isNotEmpty) {
        emit(CourseLoaded(course));
      } else {
        emit(CourseError("No categories found."));
      }
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
