
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gac_dashboard/features/auth/domain/entities/user_entity.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(LoginInitialState());

final TextEditingController emailController = TextEditingController();

final TextEditingController emailToResetPasswordController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
Icon suffixIcon = const Icon(Icons.visibility);
  bool isObscured = true;

  void changePasswordVisibility() {
    isObscured = !isObscured;
    suffixIcon = isObscured
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off);
        emit(LoginChangePasswordVisibilityState());
  }
  Future<void> signIn() async {
    emit(LoginLoadingState());
    var result = await authRepo
        .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    result.fold((failure) {
      emit(LoginFailureState(errMessage: failure.message));
    }, (user) {
      emit(LoginSuccessState(userEntity: user));
    });
  }

  Future<void> sendEmailToResetPassword()async{
    var result = await authRepo.sendPasswordResetEmail(email: emailToResetPasswordController.text);
    result.fold((failure) {
      emit(SendEmailToResetPasswordFailureState(errMessage: failure.message));
    }, (success) {
      emit(SendEmailToResetPasswordSuccessState());
    });
  }

}
