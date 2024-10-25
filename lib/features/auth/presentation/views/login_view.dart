import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/custom_snak_bar.dart';
import 'package:gac_dashboard/core/helper_functions/extentions.dart';
import 'package:gac_dashboard/core/helper_functions/routes.dart';
import 'package:gac_dashboard/core/services/get_it_service.dart';
import 'package:gac_dashboard/core/utils/app_colors.dart';
import 'package:gac_dashboard/core/utils/custom_app_bar.dart';
import 'package:gac_dashboard/features/auth/data/login_cubit/login_cubit.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:gac_dashboard/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: customAppBar(title: 'تسجيل الدخول'),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              context.pushReplacementNamed(Routes.dashboardView);
            }
            if (state is LoginFailureState) {
              showSnackBar(context, text: state.errMessage, color: Colors.red);
            }if(state is LoginChangePasswordVisibilityState){
              //SizedBox.shrink();
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
                inAsyncCall: state is LoginLoadingState,
                progressIndicator: LoadingAnimationWidget.inkDrop(
                    color: AppColors.secondaryColor, size: 32),
                child: const LoginViewBody());
          },
        ),
      ),
    );
  }

  
}
