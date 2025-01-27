import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/custom_exceptions.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/core/services/database_service.dart';
import 'package:gac_dashboard/core/utils/backend_endpoints.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';

import '../../../features/add_product/data/models/product_model.dart';
import '../../errors/failures.dart';

class ProductRepoImpl extends ProductsRepo {
  final DatabaseService databaseService;
  ProductRepoImpl({required this.databaseService});

 
  @override
   Future<Either<Failure,void>> addProduct({required ProductEntity addProductEntity}) async{
    try {
  await databaseService.addData(path: BackendEndpoints.products, data: ProductModel.fromEntity(addProductEntity).toJson(), documentId: addProductEntity.code);
  return right(null);
}  catch (e) {
  return left(ServerFailure(message: 'حدث خطاء اثناء اضافة المنتج'));
}
  }

  @override 
   Either<Failure, Stream<List<ProductEntity>>> getProductsStream({Map<String, dynamic>? query}) {
    try {
      final stream = databaseService.getDataStream(path: BackendEndpoints.products,query: query ).map((data) {
         
        return data.map((e) => ProductModel.fromJson(e).toEntity()).toList();
      });
      return Right(stream);
    } catch (e) {
      return Left(ServerFailure(message: 'فشل في تحميل المنتجات، حاول مرة اخرى!'));
    }
  }
  
  @override
  Future<Either<Failure,void>> updateProduct({required String documentId ,required ProductEntity productEntity})async {
    try {
  await databaseService.updateProduct(path: BackendEndpoints.products, documentId: documentId, 

  data:ProductModel.fromEntity(productEntity).toJson() 
  );
  return right(null);
} on CustomException catch (e) {
  return left(ServerFailure(message: e.message));
}
  }


  @override
  Future<Either<Failure, void>> deleteProduct({required String documentId})async {
    try {
  await databaseService.deleteProduct(path: BackendEndpoints.products, documentId: documentId);
  return right(null);
} on CustomException catch (e) {
  return left(ServerFailure(message: e.message));
}
  }
  
  @override
  Future<Either<Failure, String>> getProduct({required String code}) async{
    try{
      final product =await databaseService.getData(path: 'products', documentId: code);
    
      return Right(ProductModel.fromJson(product).toEntity().code);
    }catch(e){
      return Left(ServerFailure(message: e.toString()));
  }

  
}
}

