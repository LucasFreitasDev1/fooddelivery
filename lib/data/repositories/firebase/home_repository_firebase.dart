import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/datasources/firebase.dart';

class HomeRepositoryFirebase {
  FirebaseDatasource _firebase;

  HomeRepositoryFirebase(this._firebase);
  Future<QuerySnapshot> getCategories() => _firebase.getCategories();

  Future<QuerySnapshot> getSlides() {
    return Firestore.instance.collection('slides').getDocuments();
  }

  Future<QuerySnapshot> getAllProductsHomePage() =>
      Firestore.instance.collection('products').getDocuments();

  Future<DocumentSnapshot> getProductFromId(String id) =>
      Firestore.instance.collection('products').document(id).get();

/* 


  Firestore.instance
        .collection('products')
        .getDocuments()
        .then((value) => productsSnapshot = value);

         */
}
