// bottom_nav_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigation_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState());

  void onItemTapped(int index) {
    emit(BottomNavState(selectedIndex: index));
  }
}
