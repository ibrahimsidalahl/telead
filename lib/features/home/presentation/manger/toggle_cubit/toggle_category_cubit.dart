
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telead/features/home/presentation/manger/toggle_cubit/toggle_category_states.dart';


class ToggleCategoryCubit extends Cubit<ToggleCategoryState> {
  ToggleCategoryCubit() : super(CategoryInitial());

  int _selectedCategoryId = 0;

  int get selectedCategoryId => _selectedCategoryId;

  void selectCategory(int value) {
    _selectedCategoryId = value;
    emit(CategoryChanged(value));
  }
}
