import 'package:gac_dashboard/core/repos/images_repo/images_repo.dart';
import 'package:gac_dashboard/core/repos/images_repo/images_repo_impl.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo.dart';
import 'package:gac_dashboard/core/repos/products_repo/products_repo_impl.dart';
import 'package:gac_dashboard/core/services/database_service.dart';
import 'package:gac_dashboard/core/services/fire_storage.dart';
import 'package:gac_dashboard/core/services/firebase_auth_service.dart';
import 'package:gac_dashboard/core/services/firestore_service.dart';
import 'package:gac_dashboard/core/services/storage_service.dart';
import 'package:gac_dashboard/features/auth/data/auth_repo_iml.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:gac_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:gac_dashboard/features/orders/presentation/views/data/repos/orders_repo_implmentaion.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
 
getIt.registerSingleton<StorageService>(FireStorageService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<ProductsRepo>(ProductRepoImpl(databaseService: getIt<DatabaseService>()));
  
   getIt.registerSingleton<ImagesRepo>(ImagesRepoImpl(
    storageService: getIt<StorageService>(),
  ));

   getIt.registerSingleton<OrdersRepo>(OrdersRepoImpl(
    databaseService: getIt<DatabaseService>(),
  ));
}
