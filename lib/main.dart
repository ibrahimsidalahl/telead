import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:telead/core/firebase_services/firebase_services.dart';
import 'package:telead/core/services/constant.dart';
import 'package:telead/core/services/shared_preferences_singleton.dart';
import 'package:telead/features/bottom_navigation_bar/presentation/manger/bottom_navigation_cubit.dart';
import 'package:telead/features/home/presentation/manger/course_cubit/course_cubit.dart';
import 'package:telead/features/home/presentation/manger/toggle_cubit/toggle_category_cubit.dart';
import 'package:telead/features/my_courses/presentation/cubit/my_courses_cubit.dart';

import 'core/helper_funcations/on_generate_route.dart';
import 'features/auth/data/data_sources/firebase_auth_service.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/sign_in_screen.dart';
import 'features/home/presentation/manger/category_cubit/category_cubit.dart';
import 'features/home/presentation/manger/toggle_category.dart';
import 'features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'features/profile/presentation/manger/theme_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SharedPreferencesSingleton.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(AuthRepository(FirebaseAuthService())),
          ),
          BlocProvider(create: (context) => CategoryCubit()),
          BlocProvider(create: (_) => CourseCubit()),
          BlocProvider(create: (_) => ToggleCategoryCubit()),
          BlocProvider(create: (_) => BottomNavCubit()),
          BlocProvider(
            create: (context) => MyCoursesCubit(
              firestore: FirebaseFirestore.instance,
              authCubit: context.read<AuthCubit>(),
            ),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider(create: (context) => ToggleCategoryProvider()),
          ],
          child: const MyApp(),
        ),
      )

  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isOnBoardingView;

  @override
  void initState() {
    super.initState();

    // اسمع حالة اليوزر في Firebase (اختياري)
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh:  User is currently signed out!');
      } else {
        log('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh:  User is signed in!');
      }
    });

    // تحميل قيمة onBoarding من shared prefs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final value = SharedPreferencesSingleton.getBool(kIsOnBoardingView) ?? false;
      setState(() {
        isOnBoardingView = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // لسه محملش البيانات
    if (isOnBoardingView == null) {
      return const CircularProgressIndicator() ;
    }

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

            home: isOnBoardingView!
                ?  SignInScreen()
                :  OnBoardingScreen(),

          ),
        );
      },
    );
  }
}

