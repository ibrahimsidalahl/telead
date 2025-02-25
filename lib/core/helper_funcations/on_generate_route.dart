
import 'package:flutter/material.dart';

import '../../features/auth/sign_in/presentation/screens/sign_in_screen.dart';
import '../../features/auth/sign_up/presentation/screens/sign_up_screen.dart';
import '../../features/home/presentation/screens/categories_list_screen.dart';
import '../../features/home/presentation/screens/teacher.dart';
import '../../features/lets_you_in/features/screens/lets_you_in_screen.dart';
import '../../features/on_boarding/presentation/screens/on_boarding_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LetsYouInScreen.routeName:
      return MaterialPageRoute(builder: (context) => LetsYouInScreen());
      case Teacher.routeName:
      return MaterialPageRoute(builder: (context) => Teacher());
    case OnBoardingScreen.routeName:
      return MaterialPageRoute(builder: (context) => OnBoardingScreen());
    case SignInScreen.routeName:
      return MaterialPageRoute(builder: (context) => SignInScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    // case HomeScreen.routeName:
    //   return MaterialPageRoute(builder: (context) => HomeScreen());
    case CategoriesListScreen.routeName:
      return MaterialPageRoute(builder: (context) => CategoriesListScreen());

    // case ProfileScreen.routeName:
    //   return MaterialPageRoute(builder: (context) => ProfileScreen(user_id: ,));
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
