import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gac_dashboard/core/errors/custom_exceptions.dart';
import 'package:gac_dashboard/core/helper_functions/cache_helper.dart';
import 'package:gac_dashboard/core/utils/cache_helper_keys.dart';

class FirebaseAuthService {
 Future<User> signInWithEmailAndPassword(
    {required String email, required String password}) async {
  try {
    // Step 1: Sign in the user with email and password
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    // Step 2: Check if the user exists in the 'admins' collection
    final user = credential.user!;
    var adminSnapshot = await FirebaseFirestore.instance
        .collection('admins')
        .doc(user.uid)
        .get();

    // Step 3: If the user does not exist in the admins collection, throw an exception
    if (!adminSnapshot.exists) {
      throw CustomException(message: 'This account is not an admin.');
    }

    // Step 4: Return the user if everything is valid
    return user;
  } on FirebaseAuthException catch (e) {
    log('There was an exception from Firebase Auth Service: ${e.toString()}');
    throw CustomException(message: mapException(e));
  } catch (e) {
    log('There was an exception from Firebase Auth Service: ${e.toString()}');
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
