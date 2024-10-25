import 'dart:convert';

import 'package:gac_dashboard/core/helper_functions/cache_helper.dart';
import 'package:gac_dashboard/core/utils/cache_helper_keys.dart';
import 'package:gac_dashboard/features/auth/data/models/user_model.dart';
import 'package:gac_dashboard/features/auth/domain/entities/user_entity.dart';

UserEntity getUserData() {
  var jsonString=CacheHelper.getData(key: kSaveUserDataKey);
  var userEntity= UserModel.fromJson(jsonDecode(jsonString));
  return userEntity;
}