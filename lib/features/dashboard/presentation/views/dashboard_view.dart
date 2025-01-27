import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/cubits/products_cubit/products_cubit.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/core/services/get_it_service.dart';
import 'package:gac_dashboard/core/utils/custom_app_bar.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/widgets/custom_drawer.dart';
import 'package:gac_dashboard/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  
    return BlocProvider(
      create: (context) =>
          ProductsCubit(getIt.get<ProductsRepo>(),getIt.get<AuthRepo>())..getProducts(),
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        appBar: customAppBar(
            title: 'لوحة التحكم',
            leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
            )),
        body: const DashboardViewBody(),
      ),
    );
  }
}
