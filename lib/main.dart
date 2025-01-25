import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gac_dashboard/core/helper_functions/bloc_observer.dart';
import 'package:gac_dashboard/core/helper_functions/cache_helper.dart';
import 'package:gac_dashboard/core/helper_functions/on_generate_route.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/services/firebase_auth_service.dart';
import 'package:gac_dashboard/core/services/get_it_service.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/firebase_options.dart';
import 'package:gac_dashboard/generated/l10n.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  OneSignal.initialize('0a35afa9-5361-43e2-9149-df923ce38aee');

  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String getRoute() {
      var isLoggedIn = FirebaseAuthService().isLoggedIn();
      if (isLoggedIn) {
        return Routes.dashboardView;
      } else {
        return Routes.loginView;
      }
    }

    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: const Locale('ar'),
            title: 'GAC Dashboard',
            theme: ThemeData(
              fontFamily: 'Cairo',
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: onGenerateRoute,
            initialRoute: getRoute(),
          );
        });
  }
}
