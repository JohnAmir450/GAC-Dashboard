import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gac_dashboard/core/errors/custom_exceptions.dart';
import 'package:gac_dashboard/core/helper_functions/cache_helper.dart';
import 'package:gac_dashboard/core/utils/cache_helper_keys.dart';

class FirebaseAuthService {
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('there was an Exception from Firebase Auth Service: ${e.toString()}');
      throw CustomException(message: mapException(e));
    } catch (e) {
      log('there was an Exception from Firebase Auth Service: ${e.toString()}');
      throw CustomException(message: 'حدث خطأ ما، حاول مرة اخرى');
    }
  }

  Future<void> sendEmailToResetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      log('there was an Exception from sendEmailToResetPassword: ${e.toString()}');
      throw CustomException(message: 'حدث خطأ ما، حاول مرة اخرى');
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await CacheHelper.removeData(key: kSaveUserDataKey);
    } catch (e) {
      log('There was an exception while signing out: ${e.toString()}');
      throw CustomException(message: 'Failed to log out. Please try again.');
    }
  }
}
