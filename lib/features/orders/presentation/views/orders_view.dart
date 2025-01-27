import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/helper_functions/get_user_data.dart';
import 'package:gac_dashboard/core/services/get_it_service.dart';
import 'package:gac_dashboard/core/utils/custom_app_bar.dart';
import 'package:gac_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:gac_dashboard/features/orders/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/orders_view_body.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'الطلبات',
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: BlocProvider(
        create: (context) => OrdersCubit(getIt.get<OrdersRepo>())
          ..getOrder(whereConditions: [
          if (getUserData().hasAccess==false) {
              'field': 'shippingAddressModel.customerGovernment',
              'isEqualTo': getUserData().location
            }
          ], query: {
            'orderBy': 'orderDate',
            'descending': true,
          }),
        child: const OrdersViewBody(),
      ),
    );
  }
}
