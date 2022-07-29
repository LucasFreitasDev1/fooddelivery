import '../data/repositories/firebase/home_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final HomeRepository _repository;
  // ignore: unused_field

  _HomeController(this._repository);
}
