import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/home/data/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import 'my_courses_states.dart';

class MyCoursesCubit extends Cubit<MyCoursesState> {
  final FirebaseFirestore firestore;
  final AuthCubit authCubit;

  MyCoursesCubit({
    required this.firestore,
    required this.authCubit,
  }) : super(MyCoursesInitial());

  Future<void> fetchMyCourses() async {
    emit(MyCoursesLoading());

    try {
      final user = authCubit.currentUser; // جاي من AuthCubit
      if (user == null ||
          user.joinedCourses == null ||
          user.joinedCourses!.isEmpty) {
        emit(const MyCoursesError("No user courses found"));
        return;
      }










      List<CourseModel> allCourses = [];

      for (var joined in user.joinedCourses!) {
        final docSnapshot =
        await firestore.doc(joined.path).get() as DocumentSnapshot<Map<String, dynamic>>;


        if (docSnapshot.exists && docSnapshot.data() != null) {
          final course = CourseModel.fromJson(docSnapshot);

        }
      }

      if (allCourses.isEmpty) {
        emit(const MyCoursesError("No valid courses found"));
      } else {
        emit(MyCoursesLoaded(allCourses));
      }
    } catch (e, stack) {
      print("Error: $e\n$stack");
      emit(MyCoursesError("Error fetching courses: $e"));
    }
  }
}
