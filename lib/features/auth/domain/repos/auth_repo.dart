import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/failures.dart';
import 'package:gac_dashboard/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
 Future<Either<Failure,UserEntity>> signInWithEmailAndPassword({required String email,required String password});

Future saveUserData({required UserEntity user });
  Future<UserEntity> getUserData({ required String uId});

  Future<Either<Failure,void>> sendPasswordResetEmail({required String email});
  }
