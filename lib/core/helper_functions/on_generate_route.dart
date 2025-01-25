import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/cubits/product_updates/product_updates_cubit.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/core/services/get_it_service.dart';
import 'package:gac_dashboard/features/Auth/presentation/views/login_view.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';
import 'package:gac_dashboard/features/add_product/presentation/views/add_product_view.dart';
import 'package:gac_dashboard/features/auth/presentation/views/widgets/reset_password_view.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:gac_dashboard/features/orders/presentation/views/orders_view.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/update_product_view.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.loginView:
      return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.resetPasswordView:
      return MaterialPageRoute(builder: (_) => const ResetPasswordView());
    case Routes.dashboardView:
      return MaterialPageRoute(builder: (_) => const DashboardView());
    case Routes.addProductView:
      return MaterialPageRoute(builder: (_) => const AddProductView());
      case Routes.ordersView:
      return MaterialPageRoute(builder: (_) => const OrdersView());
    case Routes.updateProductView:
      var productEntity = settings.arguments as ProductEntity;
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) => ProductUpdatesCubit(getIt.get<ProductsRepo>()),
                child: UpdateProductView(
                  productEntity: productEntity,
                ),
              ));
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ));
  }
}
