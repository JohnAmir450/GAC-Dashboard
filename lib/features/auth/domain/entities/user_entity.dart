import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  String? name;
  String? email;
  String? phoneNumber;
  String? location;
  String? uId;
  bool? hasAccess;

  UserEntity({
    required this.name,
    required this.email,
    required this.hasAccess,
    required this.uId,
    required this.phoneNumber,
    required this.location
  });

  UserEntity.fromFirebase(User user) {
    email = user.email!;
    name = user.displayName!;
    uId = user.uid;
    phoneNumber = user.phoneNumber!;
    location = '';
  }
  toMap() {
    return {
      'email': email,
      'name': name,
      'uId': uId,
      'phoneNumber': phoneNumber,
      'location': location,
      'hasAccess': hasAccess
    };
  }
}
