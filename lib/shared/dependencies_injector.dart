import 'package:get_it/get_it.dart';

import '../layers/data/datasources/firebase.dart';
import '../layers/controller/home_controller.dart';
import '../layers/data/repositories/firebase/home_repository.dart';

GetIt inject = GetIt.instance;

initGetIt() {
  //getIt instance fills depency automagically

  //datasources
  inject.registerLazySingleton(() => FirebaseDatasource());

  //repositories
  inject.registerLazySingleton(() => HomeRepository(inject()));

  //controllers
  inject.registerLazySingleton(() => HomeController(inject()));
}
