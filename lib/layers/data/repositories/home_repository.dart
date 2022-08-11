import '../../model/button_category_model.dart';
import '../../model/product_model.dart';
import '../../model/slide_model.dart';
import '../datasources/firebase_datasource.dart';

class HomeRepository {
  FirebaseDatasource _firebase;

  HomeRepository(this._firebase);
  Future<List<CategoryButtonModel>?>? getCategories() =>
      _firebase.getCategoriesButtons();

  Future<List<ProductModel?>?> getProdutcsCategories(String categoryTitle) =>
      _firebase.getProdutcsCategories(categoryTitle);

  Future<List<SlideModel>?> getSlides() => _firebase.getSlides();

  Future<List<ProductModel>?> getAllProductsHomePage() =>
      _firebase.getAllProductsHomePage();

  Future<String> getImageCategory(String img) =>
      _firebase.getImageCategory(img);

  Future<ProductModel?> getProductFromId(String idProduct) =>
      _firebase.getProductFromId(idProduct);
}
