abstract class ToggleCategoryState {}

class CategoryInitial extends ToggleCategoryState {}

class CategoryChanged extends ToggleCategoryState {
  final int selectedCategoryId;

  CategoryChanged(this.selectedCategoryId);
}
