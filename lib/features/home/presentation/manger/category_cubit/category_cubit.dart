import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/firebase_services/firebase_services.dart';
import '../../../data/models/category_model.dart';
import 'category_states.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  final FirebaseServices _firebaseServices = FirebaseServices();

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final List<CategoryModel> categories = await _firebaseServices.fetchAllCategories();
      if (categories.isNotEmpty) {
        emit(CategoryLoaded(categories));
      } else {
        emit(CategoryError("No categories found."));
      }
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
