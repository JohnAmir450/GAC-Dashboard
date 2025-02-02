import 'package:dartz/dartz.dart';
import 'package:gac_dashboard/core/errors/failures.dart';
import 'package:gac_dashboard/features/add_product/domain/entities/product_entity.dart';

abstract class ProductsRepo {
  Future<Either<Failure,void>> addProduct({required ProductEntity addProductEntity});

Either<Failure, Stream<List<ProductEntity>>> getProductsStream({Map<String, dynamic>? query});

Future<Either<Failure,void>> updateProduct({required String documentId, required ProductEntity productEntity});

Future<Either<Failure,void>> deleteProduct({required String documentId});

Future<Either<Failure,String>> getProduct({required String code}); 

 
}