import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/productData.dart';
import 'package:food_delivery_app/model/slide_model.dart';
import 'package:food_delivery_app/view/screens/cart/cart_screen.dart';
import 'package:food_delivery_app/view/screens/product/productPage.dart';

class CarouselSliderHome extends StatelessWidget {
  CarouselSliderHome(
      {Key key,
      @required List<SlideModel> slides,
      @required QuerySnapshot productsSnapshot})
      : super(key: key);

  List<SlideModel> slides;
  // var _current = 0;
  QuerySnapshot productsSnapshot;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: slides
            .map((SlideModel item) => Container(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              child: Image.network(item.imageFit,
                                  fit: BoxFit.cover),
                              onTap: item.store.isEmpty && item.food.isEmpty
                                  ? () {}
                                  : () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) {
                                          if (item.food != '') {
                                            return ProductScreen(
                                              ProductData.fromDocument(
                                                  productsSnapshot.documents
                                                      .single[item.food]),
                                            );
                                          } else if (item.store != '') {
                                            ///apenas um teste
                                            ///falta criar pagina para restaurante
                                            return CartPage();
                                          }
                                          return null;
                                        }),
                                      ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  'No. ${slides.indexOf(item)} image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            enlargeCenterPage: true));
  }
}
