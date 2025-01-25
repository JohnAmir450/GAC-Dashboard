import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/widgets/custom_animated_loading_widget.dart';
import 'package:gac_dashboard/features/orders/presentation/manager/orders_cubit/orders_cubit.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/filter_section.dart';
import 'package:gac_dashboard/features/orders/presentation/views/widgets/orders_items_list_view.dart';


class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: FilterSection(),
        ),
        BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
          if (state is GetOrdersSuccessState) {
            return OrdersItemsListView(
              orders: state.orders,
              itemCount: state.orders.length,
            );
          } else if (state is GetOrdersFailureState) {
            return SliverToBoxAdapter(child: Text(state.errorMessage));
          } else {
            return const SliverToBoxAdapter(child: Center(child:  CustomAnimatedLoadingWidget(),),);
          }
        }),
      ],
    );
  }
}
