import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gac_dashboard/core/errors/custom_exceptions.dart';

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
}