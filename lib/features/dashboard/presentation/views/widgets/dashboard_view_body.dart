import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/cubits/products_cubit/products_cubit.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/helper_functions/get_user_data.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/utils/app_colors.dart';
import 'visible_products_list_view.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحبًا بك !',
                style: TextStyles.regular16.copyWith(
                  color: const Color(0xff949D9E),
                ),
                
              ),
              Text(getUserData().name!, style: TextStyles.bold16),
              verticalSpace(16),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Visibility(
                  visible: getUserData().hasAccess ?? false,
                  child: CustomButton(height: 70,
                      text: ' اضافة منتج',
                      onPressed: () {
                        context.pushNamed(Routes.addProductView);
                      }),
                ),
              ),
              verticalSpace(16),
              CustomButton(height: 70,
                  text: '  الطلبات',
                  onPressed: () {
                    context.pushNamed(Routes.ordersView);
                  }),
              verticalSpace(16),
              const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'المنتجات المعروضة ',
                    style: TextStyles.bold19,
                  )),
              verticalSpace(16),
            ],
          ),
        ),
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if(state is ProductsLoadingState){
              return SliverToBoxAdapter(
                child: Center(child: LoadingAnimationWidget.inkDrop(color: AppColors.primaryColor, size: 32),),
              );
            }else if (state is ProductsSuccessState) {
            return  VisibleProductsListView(products: state.products,);
          } else if (state is ProductsFailureState) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.errorMessage)),
            );
          } else {
            return const SliverToBoxAdapter(child: Center(child: Text('لا يوجد اي منتاجات معروضة حتى الان')));
          }
          },
        ),
      ]),
    );
  }
}
