import 'package:gac_dashboard/core/services/database_service.dart';
import 'package:gac_dashboard/core/services/firebase_auth_service.dart';
import 'package:gac_dashboard/core/services/firestore_service.dart';
import 'package:gac_dashboard/features/auth/data/auth_repo_iml.dart';
import 'package:gac_dashboard/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );
}
