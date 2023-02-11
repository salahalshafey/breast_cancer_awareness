import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';

import 'features/account/data/datasources/account_remote_authentication.dart';
import 'features/account/data/datasources/account_remote_data_source.dart';
import 'features/account/data/datasources/account_remote_storage.dart';
import 'features/account/data/repositories/account_repository_impl.dart';
import 'features/account/domain/repositories/account_repository.dart';
import 'features/account/domain/usecases/get_user_information.dart';
import 'features/account/domain/usecases/signin_with_email_and_password.dart';
import 'features/account/domain/usecases/signup_with_email_and_password.dart';
import 'features/account/presentation/providers/Account.dart';

final sl = GetIt.instance;

Future<void> init() async {
/////////////////////////////////////////////// !!!! Features - Account !!!! /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Provider

  sl.registerFactory(() => Account(
        getUserInformation: sl(),
        signUserInUsingEmailAndPassword: sl(),
        signUserUpUsingEmailAndPassword: sl(),
      ));

// Usecases

  sl.registerLazySingleton(() => GetUserInformationUsecase(sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPasswordUsecase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPasswordUsecase(sl()));

// Repository

  sl.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(
        remoteDataSource: sl(),
        remoteStorage: sl(),
        remoteAuth: sl(),
        networkInfo: sl(),
      ));

// Datasources

  sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountFirestoreImpl());
  sl.registerLazySingleton<AccountRemoteStorage>(
      () => AccountFirebaseStorageImpl());
  sl.registerLazySingleton<AccountRemoteAuthentication>(
      () => AccountFirebaseAuthenticationImpl());

/////////////////////////////////////////////// !!!! Features - Articles !!!! /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Provider
  /** and so on................ */

//////////////////////////////////////////////////// !!!! core !!!! ///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
