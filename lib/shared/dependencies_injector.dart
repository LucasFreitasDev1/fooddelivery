import 'package:get_it/get_it.dart';

import '../data/datasources/firebase.dart';

GetIt inject = GetIt.instance;

initGetIt() {
  //getIt instance fills depency automagically

  //datasources
  inject.registerLazySingleton(() => FirebaseDatasource());

  //repositories

  //controllers
}
