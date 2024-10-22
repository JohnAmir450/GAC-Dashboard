import 'package:flutter/material.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/features/Auth/presentation/views/login_view.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/dashboard_view.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.loginView:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case Routes.dashboardView:
      return MaterialPageRoute(builder: (_) => const DashboardView());
// case Routes.addProductView:
//       return MaterialPageRoute(builder: (_) => const AddProductView());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}