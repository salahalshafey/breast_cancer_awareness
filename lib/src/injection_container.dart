import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';

import 'features/account/data/datasources/account_remote_authentication.dart';
import 'features/account/data/datasources/account_local_data_source.dart';
import 'features/account/data/datasources/account_remote_data_source.dart';
import 'features/account/data/datasources/account_remote_storage.dart';
import 'features/account/data/repositories/account_repository_impl.dart';
import 'features/account/domain/repositories/account_repository.dart';
import 'features/account/domain/usecases/add_or_update_user_data.dart';
import 'features/account/domain/usecases/delete_every_thing_to_current_user_use_case.dart';
import 'features/account/domain/usecases/get_user_information.dart';
import 'features/account/domain/usecases/sign_in_anonymously.dart';
import 'features/account/domain/usecases/signin_with_email_and_password.dart';
import 'features/account/domain/usecases/signup_with_email_and_password.dart';
import 'features/account/domain/usecases/send_user_image_and_type.dart';
import 'features/account/presentation/providers/account.dart';

import 'features/breast_cancer_for_normal/data/datasources/notes_local_data_source.dart';
import 'features/breast_cancer_for_normal/data/datasources/notes_local_storage.dart';
import 'features/breast_cancer_for_normal/data/repositories/notes_repositories_impl.dart';
import 'features/breast_cancer_for_normal/domain/repositories/notes_repositories.dart';
import 'features/breast_cancer_for_normal/domain/usecases/gt_all_notes.dart';
import 'features/breast_cancer_for_normal/domain/usecases/add_note.dart';
import 'features/breast_cancer_for_normal/domain/usecases/delete_note.dart';
import 'features/breast_cancer_for_normal/domain/usecases/delete_all_notes.dart';
import 'features/breast_cancer_for_normal/presentation/providers/notes.dart';

import 'features/breast_cancer_for_patient/data/datasources/ai_chat.dart';
import 'features/breast_cancer_for_patient/data/datasources/google_scholar_search.dart';
import 'features/breast_cancer_for_patient/data/datasources/google_search.dart';
import 'features/breast_cancer_for_patient/data/datasources/wikipedia_search.dart';
import 'features/breast_cancer_for_patient/data/repositories/search_repositories_impl.dart';
import 'features/breast_cancer_for_patient/domain/repositories/search_repositories.dart';
import 'features/breast_cancer_for_patient/domain/usecases/ai_result.dart';
import 'features/breast_cancer_for_patient/domain/usecases/custom_web_search.dart';
import 'features/breast_cancer_for_patient/presentation/providers/search.dart';

final sl = GetIt.instance;

Future<void> init() async {
/////////////////////////////////////////////// !!!! Features - Account !!!! /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Provider

  sl.registerFactory(() => Account(
        getUserInformationUseCase: sl(),
        signUserInAnonymouslyUseCase: sl(),
        signUserInUsingEmailAndPasswordUseCase: sl(),
        signUserUpUsingEmailAndPasswordUseCase: sl(),
        sendUserImageAndTypeUseCase: sl(),
        addOrApdateUserDataUsecase: sl(),
        deleteEveryThingToCurrentUserUsecase: sl(),
      ));

// Usecases

  sl.registerLazySingleton(() => GetUserInformationUsecase(sl()));
  sl.registerLazySingleton(() => SignInAnonymouslyUsecase(sl()));
  sl.registerLazySingleton(() => SignInWithEmailAndPasswordUsecase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailAndPasswordUsecase(sl()));
  sl.registerLazySingleton(() => SendUserImageAndTypeUseCase(sl()));
  sl.registerLazySingleton(() => AddOrUpdateUserDataUsecase(sl()));
  sl.registerLazySingleton(() => DeleteEveryThingToCurrentUserUsecase(sl()));

// Repository

  sl.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        remoteStorage: sl(),
        remoteAuth: sl(),
        networkInfo: sl(),
      ));

// Datasources

  sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountFirestoreImpl());
  sl.registerLazySingleton<AccountLocalDataSource>(
      () => AccountSharedPreferencesImpl());
  sl.registerLazySingleton<AccountRemoteStorage>(
      () => AccountFirebaseStorageImpl());
  sl.registerLazySingleton<AccountRemoteAuthentication>(
      () => AccountFirebaseAuthenticationImpl());

/////////////////////////////////////////////// !!!! Features - Notes !!!! /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Provider

  sl.registerFactory(() => Notes(
        getAllNotesUsecase: sl(),
        addNoteUsecase: sl(),
        deleteNoteUsecase: sl(),
        deleteAllNotesUsecase: sl(),
      ));

// Usecases

  sl.registerLazySingleton(() => GetAllNotesUsecase(sl()));
  sl.registerLazySingleton(() => AddNoteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUsecase(sl()));
  sl.registerLazySingleton(() => DeleteAllNotesUsecase(sl()));

// Repository

  sl.registerLazySingleton<NotesRepository>(() => NotesRepositoryImpl(
        localDataSource: sl(),
        localStorage: sl(),
      ));

// Datasources

  sl.registerLazySingleton<NotesLocalDataSource>(
      () => NotesSharedPreferencesImpl());
  sl.registerLazySingleton<NotesLocalStorage>(() => NotesLocalStorageImpl());

  /////////////////////////////////////////////// !!!! Features - Search !!!! /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Provider

  sl.registerFactory(() => Search(
        customWebSearchUsecase: sl(),
        aiResultUsecase: sl(),
      ));

// Usecases

  sl.registerLazySingleton(() => CustomWebSearchUsecase(sl()));
  sl.registerLazySingleton(() => AIResultUsecase(sl()));

// Repository

  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(
        aiChat: sl(),
        googleSearch: sl(),
        googleScholarSearch: sl(),
        wikipediaSearch: sl(),
        networkInfo: sl(),
      ));

// Datasources

  sl.registerLazySingleton<AIChat>(() => GeminiPro());
  sl.registerLazySingleton<GoogleSearch>(() => GoogleSearchScrappingImpl());
  sl.registerLazySingleton<GoogleScholarSearch>(
      () => GoogleScholarScrappingImpl());
  sl.registerLazySingleton<WikipediaSearch>(() => WikipediaScrappingImpl());

//////////////////////////////////////////////////// !!!! core !!!! ///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  sl.registerLazySingleton<NetworkInfo>(() => MyNetworkInfoImpl());
}
