import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepositoryFirebase {
  Future<QuerySnapshot> getCategories() {
    return Firestore.instance.collection('category').getDocuments();
  }

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
