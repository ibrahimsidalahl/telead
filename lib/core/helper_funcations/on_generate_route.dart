import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home/presentation/screens/categories_list_screen.dart';
import '../../features/lets_you_in/features/screens/lets_you_in_screen.dart';
import '../../features/on_boarding/presentation/screens/on_boarding_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LetsYouInScreen.routeName:
      return MaterialPageRoute(builder: (context) => LetsYouInScreen());

    case OnBoardingScreen.routeName:
      return MaterialPageRoute(builder: (context) => OnBoardingScreen());
    case SignInScreen.routeName:
      return MaterialPageRoute(builder: (context) => SignInScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (context) => SignUpScreen());

    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
