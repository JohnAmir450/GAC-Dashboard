import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/core/services/database_service.dart';
import 'package:gac_dashboard/core/utils/backend_endpoints.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/add_product_entity.dart';

import '../../../features/add_product/data/models/add_product_model.dart';
import '../../errors/failures.dart';

class ProductRepoImpl extends ProductsRepo {
  final DatabaseService databaseService;
  ProductRepoImpl({required this.databaseService});
  @override
   Future<Either<Failure,void>> addProduct({required AddProductEntity addProductEntity}) async{
    try {
  await databaseService.addData(path: BackendEndpoints.products, data: AddProductModel.fromEntity(addProductEntity).toJson());
  return right(null);
}  catch (e) {
  return left(ServerFailure(message: 'حدث خطاء اثناء اضافة المنتج'));
}
  }
  
}