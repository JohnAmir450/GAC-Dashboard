import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/helper_functions/custom_snak_bar.dart';
import 'package:gac_dashboard/core/services/get_it_service.dart';
import 'package:gac_dashboard/core/utils/custom_app_bar.dart';
import 'package:gac_dashboard/features/auth/data/login_cubit/login_cubit.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:gac_dashboard/features/auth/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: customAppBar(
          title: 'تغيير كلمة المرور',
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if(state is SendEmailToResetPasswordSuccessState){
              showSnackBar(context, text: 'تم ارسال رسالة اعادة تعين الرقم السري الخاص بك');
            }
            if(state is SendEmailToResetPasswordFailureState){  
              showSnackBar(context, text: state.errMessage, color: Colors.red);
            }
          },
          child: const EmailResetPasswordViewBody(),
        ),
      ),
    );
  }
}
