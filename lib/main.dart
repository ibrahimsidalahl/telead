import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:telead/features/auth/sign_up/presentation/manger/sign_up_provider.dart';
import 'package:telead/features/home/presentation/screens/lessons_screen.dart';
import 'package:telead/features/on_boarding/presentation/screens/on_boarding_screen.dart';

import 'core/helper_funcations/on_generate_route.dart';
import 'features/auth/sign_in/presentation/screens/sign_in_screen.dart';
import 'features/bottom_navigation_bar/presentation/manger/bottom_navigation_provider.dart';
import 'features/home/presentation/manger/category_provider.dart';
import 'features/home/presentation/manger/courses_provider.dart';
import 'features/home/presentation/manger/toggle.dart';
import 'features/home/presentation/manger/toggle_category.dart';
import 'features/on_boarding/presentation/manger/on_boarding_provider.dart';
import 'features/profile/presentation/manger/theme_provider.dart';
import 'features/profile/presentation/manger/user_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => ToggleCategoryProvider()),
      ChangeNotifierProvider(create: (context) => OnBoardingProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => CoursesProvider()),
      ChangeNotifierProvider(create: (context) => UsersProvider()),
      ChangeNotifierProvider(create: (context) => ToggleProvider()),
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
    ],
    child: MyApp(),
  ));
  FlutterNativeSplash.remove();
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return SafeArea(
          child: MaterialApp(
              onGenerateRoute: onGenerateRoute,
              debugShowCheckedModeBanner: false,
              theme: Provider.of<ThemeProvider>(context).getCurrentTheme(),
              home: OnBoardingScreen()
          ),
        );
      },
    );
  }
}
