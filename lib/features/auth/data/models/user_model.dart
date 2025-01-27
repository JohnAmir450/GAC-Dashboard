import 'package:firebase_auth/firebase_auth.dart';
import 'package:gac_dashboard/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.email,
      required super.name,
      required super.uId,
      required super.phoneNumber,
      required super.location,
      required super.hasAccess
      });
  factory UserModel.fromFirebase(User user) {
    return UserModel(
      email: user.email ?? '',
      name: user.displayName ?? '',
      uId: user.uid,
      phoneNumber: user.phoneNumber ?? '',
      location: '',
      hasAccess: false,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      uId: json['uId'],
      phoneNumber: json['phoneNumber'],
      location: json['location'],
      hasAccess: json['hasAccess'],
    );
  }
}
