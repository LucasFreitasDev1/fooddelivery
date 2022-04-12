import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/repositories/firebase/home_repository_firebase.dart';

class HomeBloc extends BlocBase {
  HomeRepositoryFirebase _repository;
  HomeBloc() {
    _repository = HomeRepositoryFirebase();
  }

  Future<QuerySnapshot> getCategories() => _repository.getCategories();

  Future<QuerySnapshot> getSlides() => _repository.getSlides();

  Future<QuerySnapshot> getAllProductsHomePage() =>
      _repository.getAllProductsHomePage();

  Future<DocumentSnapshot> getProductFromId(String id) async =>
      await _repository.getProductFromId(id);

  @override
  void dispose() {}
}
