import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/core/utils/spacing.dart';
import 'package:gac_dashboard/core/widgets/custom_button.dart';
import 'package:gac_dashboard/core/widgets/custom_text_field.dart';
import 'package:gac_dashboard/features/auth/data/login_cubit/login_cubit.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              verticalSpace(30),
              Image.asset('assets/images/app_logo.png'),
              verticalSpace(50),
              CustomTextFormField(
                hintText: 'البريد الالكتروني',
                controller: cubit.emailController,
                textInputType: TextInputType.emailAddress,
                onChanged: (value) {
                  cubit.emailController.text = value;
                },
              ),
              verticalSpace(16),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomTextFormField(
                    hintText: 'كلمة المرور',
                    controller: cubit.passwordController,
                    isObscured: cubit.isObscured,
                    textInputType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      cubit.passwordController.text = value;
                    },
                    suffixIcon: GestureDetector(
                        onTap: () {
                          cubit.changePasswordVisibility();
                        },
                        child: cubit.suffixIcon),
                  );
                },
              ),
              verticalSpace(60),
              CustomButton(
                  text: 'تسجيل الدخول',
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.signIn();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
