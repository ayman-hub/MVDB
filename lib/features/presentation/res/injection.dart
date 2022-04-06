




import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tmdb_task/features/data/data_sources/local_data/shared_preferences.dart';
import 'package:tmdb_task/features/data/remote_data/dio_helper.dart';
import 'package:tmdb_task/features/data/remote_data/dio_remote.dart';
import 'package:tmdb_task/features/data/repositories/data_repositry.dart';
import 'package:tmdb_task/features/domain/repositories/domain_repositry.dart';
import 'package:tmdb_task/features/domain/use_cases/case.dart';





final sl = GetIt.instance;

Future<void> init()async{
  //! feature
  // for bloc
  // * cases
  sl.registerLazySingleton(
          () => Cases(domainRepositry: sl())); //? need domain repositry



  // * repository
  sl.registerLazySingleton<DomainRepositry>(
          () => DataRepositry(getSharedPreference: sl(), dioRemote: sl()));

  //! external
  //sl.registerLazySingleton(() => RemoteData(firestore: sl()));
  sl.registerLazySingleton(() => DioRemote(DioHelper()));
  sl.registerLazySingleton(() => GetSharedPreference(sharedPreferences: sl()));
  // * database from local data source
  //sl.registerLazySingleton(() => DBHelper());
 // sl.registerLazySingleton(() => FirebaseFirestore.instance);
  await GetStorage.init();
  final sharedPreferences = GetStorage();
  sl.registerLazySingleton<GetStorage>(() => sharedPreferences);
}
