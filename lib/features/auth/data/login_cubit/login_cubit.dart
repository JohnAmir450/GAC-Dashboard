
import 'dart:async';

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
bool _isEmailButtonDisabled = false;
  int _resendEmailTimerSeconds = 0;
  Timer? _timer;

  bool get isEmailButtonDisabled => _isEmailButtonDisabled;
  int get resendEmailTimerSeconds => _resendEmailTimerSeconds;
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

  Future<void> sendEmailToResetPassword() async {
    if (_isEmailButtonDisabled) return; // Prevent multiple presses

    //emit(SendEmailToResetPasswordLoadingState()); // Add loading state

    _isEmailButtonDisabled = true;
    _resendEmailTimerSeconds = 60; // Set timer duration
    emit(SendEmailToResetPasswordTimerState(_resendEmailTimerSeconds)); //Emit timer state

    _startTimer();

    var result = await authRepo.sendPasswordResetEmail(
        email: emailToResetPasswordController.text);

    result.fold((failure) {
      emit(SendEmailToResetPasswordFailureState(errMessage: failure.message));
      _resetButtonState(); // Enable button and reset timer on failure.
    }, (success) {
      emit(SendEmailToResetPasswordSuccessState());
    });
  }


  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendEmailTimerSeconds > 0) {
        _resendEmailTimerSeconds--;
        emit(SendEmailToResetPasswordTimerState(_resendEmailTimerSeconds));
      } else {
        _timer?.cancel();
        _resetButtonState();
      }
    });
  }

  void _resetButtonState() {
    _isEmailButtonDisabled = false;
    _resendEmailTimerSeconds = 0;
    emit(SendEmailToResetPasswordTimerState(_resendEmailTimerSeconds)); // Emit 0 to update the UI
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    return super.close();
  }
 

}
