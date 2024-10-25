import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/failures.dart';
import 'package:gac_dashboard/core/repos/images_repo/images_repo.dart';
import 'package:gac_dashboard/core/services/storage_service.dart';

import '../../utils/backend_endpoints.dart';

class ImagesRepoImpl extends ImagesRepo{
  final StorageService storageService;

  ImagesRepoImpl({required this.storageService});
  @override
  Future<Either<Failure, String>> uploadImage({required File image}) async{
   try {
  String imageUrl=await storageService.uploadFile(image, BackendEndpoints.images);
  return Right(imageUrl);
}  catch (e) {
  return left(ServerFailure(message: 'حدث خطأ اثناء اضافة الصورة'));
}
  }
  
}