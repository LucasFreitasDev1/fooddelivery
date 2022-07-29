import '../datasources/firebase.dart';
import'../../model/slide_model.dart';
class HomeRepository {
  FirebaseDatasource _firebase;

  HomeRepository(this._firebase);
  Future<List<CategoryButtonModel>?>? getCategories() =>
      _firebase.getCategoriesButtons();

  Future<List<SlideModel>?> getSlides() => _firebase.getSlides();

  Future<List<ProductModel>?> getAllProductsHomePage() =>
      _firebase.getAllProductsHomePage();



