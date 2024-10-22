import 'package:firebase_auth/firebase_auth.dart';

class CustomException implements Exception {
  final String message;

  CustomException({required this.message});

  @override
  String toString() {
    return message;
  }
}

String mapException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
       return  'كلمة المرور ضعيفة';
      case 'email-already-in-use':
       return  'هذا البريد مستخدم من قبل';
      case 'user-not-found':
      return  'هذا البريد غير موجود';
      case 'wrong-password':
       return  'كلمة المرور غير صحيحة';
      case 'invalid-credential':
       return 'تأكد من صحة بياناتك';
      case 'invalid-email':
       return  'البريد غير صالح';
      case 'operation-not-allowed':
       return  'لم يتم تفعيل حسابك';
      case 'user-disabled':
       return  'تم تعطيل حسابك';
      case 'network-request-failed':
       return  'تأكد من الاتصال بالانترنت';
      default:
       return  'حدث خطأ ما، حاول مرة اخرى';
    }
  } 