import 'package:food_delivery_app/layers/model/button_category_model.dart';
import 'package:food_delivery_app/layers/model/product_model.dart';
import 'package:food_delivery_app/layers/model/slide_model.dart';
import 'package:mobx/mobx.dart';

import '../data/repositories/home_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final HomeRepository _repository;
  // ignore: unused_field

  _HomeController(this._repository);

  Future<List<CategoryButtonModel>?>? getCategories() =>
      _repository.getCategories();

  Future<List<ProductModel>?> getAllProductsHomePage() =>
      _repository.getAllProductsHomePage();

  Future<List<SlideModel>?> getSlides() => _repository.getSlides();

  Future<String> getImageCategory(String img) =>
      _repository.getImageCategory(img);

  Future<List<ProductModel?>?> getProdutcsCategories(String categoryTitle) =>
      _repository.getProdutcsCategories(categoryTitle);

  Future<ProductModel?> getProductFromId(String idProduct) =>
      _repository.getProductFromId(idProduct);
}
