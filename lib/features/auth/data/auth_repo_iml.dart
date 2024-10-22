import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/custom_exceptions.dart';
import 'package:gac_dashboard/core/errors/failures.dart';
import 'package:gac_dashboard/core/helper_functions/cache_helper.dart';
import 'package:gac_dashboard/core/services/firebase_auth_service.dart';
import 'package:gac_dashboard/core/utils/backend_endpoints.dart';
import 'package:gac_dashboard/core/utils/cache_helper_keys.dart';
import 'package:gac_dashboard/features/auth/data/models/user_model.dart';
import 'package:gac_dashboard/features/auth/domain/entities/user_entity.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';

import '../../../core/services/database_service.dart';

class AuthRepoImpl extends AuthRepo{
  final FirebaseAuthService firebaseAuthService;
   final DatabaseService databaseService;

  AuthRepoImpl({required this.firebaseAuthService,required this.databaseService});
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({required String email, required String password})async {
    try {
  var user =await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
  var userEntity=await getUserData(uId: user.uid);
  await saveUserData(user: userEntity);
  return Right(userEntity);
} on CustomException catch (e) {
  return Left(ServerFailure(message: e.message));
} catch (e) { 
  return Left(ServerFailure(message: 'حدث خطأ ما، حاول مرة اخرى'));
  }
  }
  
  @override
  Future<UserEntity> getUserData({required String uId}) async {
    var userData= await databaseService.getData(path: BackendEndpoints.getUserData,documentId: uId);
    return UserModel.fromJson(userData);
  }

  
  @override
  Future saveUserData({required UserEntity user})async {
   var userData=jsonEncode(user.toMap());
   await CacheHelper.saveData(key: kSaveUserDataKey, value: userData);
  }
  
  }