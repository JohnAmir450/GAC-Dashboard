import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/failures.dart';

abstract class ImagesRepo {
  Future <Either<Failure,String>>uploadImage({required File image});
}