import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/bloc_observer.dart';
import 'package:gac_dashboard/core/helper_functions/on_generate_route.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GAC Dashboard',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: Routes.loginView, 
    );
  }
}

