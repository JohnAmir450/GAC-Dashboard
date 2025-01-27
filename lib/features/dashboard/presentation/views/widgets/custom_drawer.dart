import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gac_dashboard/core/cubits/products_cubit/products_cubit.dart';
import 'package:gac_dashboard/core/helper_functions/cusom_quick_alret_view.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/helper_functions/get_user_data.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/app_text_styles.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsSuccessState) {
              return Column(
                children: [
                  verticalSpace(100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'مرحبًا بك, ',
                        style: TextStyles.bold23,
                      ),
                      Text(
                        getUserData().name!,
                        style: TextStyles.bold23
                            .copyWith(color: AppColors.primaryColor),
                      )
                    ],
                  ),
                  const Text('مسؤول محافظة ', style: TextStyles.semiBold16),
                  Text(getUserData().location.toString(),
                      style: TextStyles.bold16),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      customQuickAlertView(context,
                          text: ' هل تريد تسجيل الخروج ؟',
                          title: 'تسجيل الخروج',
                          confirmBtnText: 'نعم',
                          type: QuickAlertType.confirm, onConfirmBtnTap: () {
                        context.read<ProductsCubit>().signOut();
                        context.pushNamed(Routes.loginView);
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'تسجيل خروج',
                          style: TextStyles.semiBold13
                              .copyWith(color: Colors.red, fontSize: 18),
                        ),
                        horizontalSpace(8.w),
                        const Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  verticalSpace(100.h),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
