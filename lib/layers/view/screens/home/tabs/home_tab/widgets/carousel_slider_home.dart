import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/home_bloc.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:food_delivery_app/model/slide_model.dart';
import 'package:food_delivery_app/view/screens/cart/cart_screen.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/carousel_slider_loader.dart';
import 'package:food_delivery_app/view/screens/product/productPage.dart';

class CarouselSliderHome extends StatefulWidget {
  CarouselSliderHome({Key key}) : super(key: key);

  @override
  _CarouselSliderHomeState createState() => _CarouselSliderHomeState();
}

class _CarouselSliderHomeState extends State<CarouselSliderHome> {
  var _current = 0;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);

    return FutureBuilder<QuerySnapshot>(
        future: bloc.getSlides(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              fit: StackFit.passthrough,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 12),
                  child: CarouselSlider.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      SlideModel slide = SlideModel.fromDocument(
                          snapshot.data.documents.elementAt(index));

                      return Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                GestureDetector(
                                  child: Image.network(slide.imageFit,
                                      fit: BoxFit.cover),
                                  onTap: slide.storeId.isEmpty &&
                                          slide.foodId.isEmpty
                                      ? () {}
                                      : () => Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                              if (slide.foodId != '') {
                                                bloc
                                                    .getProductFromId(
                                                        slide.foodId)
                                                    .then((value) {
                                                  return ProductScreen(
                                                    ProductModel.fromDocument(
                                                        value),
                                                  );
                                                });
                                              } else if (slide.storeId != '') {
                                                ///apenas um teste
                                                ///falta criar pagina para restaurante
                                                return CartPage();
                                              }
                                              return null;
                                            }),
                                          ),
                                ),
                              ],
                            )),
                      );
                    },
                    options: CarouselOptions(
                        onPageChanged: (item, reason) {
                          setState(() {
                            _current = item;
                          });
                        },
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        height: 180,
                        enlargeCenterPage: true),
                  ),
                ),

                /// Indicação de slide
                ///
                Container(
                  padding: EdgeInsets.only(top: 50),
                  alignment: Alignment.bottomCenter,
                  //margin: EdgeInsets.symmetric(vertical: 22, horizontal: 42),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data.documents.map((slide) {
                      return Container(
                        width: 6,
                        height: 6,
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: _current ==
                                    snapshot.data.documents.indexWhere(
                                        (element) =>
                                            element.documentID ==
                                            slide.documentID)
                                ? Colors.blueGrey
                                : Colors.blueGrey.withOpacity(0.3)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }

          return CarouselSliderLoader();
        });
  }
}

/* 
 items:
              
              slides
                  .map((SlideModel item) => Container(
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Image.network(item.imageFit,
                                        fit: BoxFit.cover),
                                    onTap: item.store.isEmpty &&
                                            item.food.isEmpty
                                        ? () {}
                                        : () => Navigator.of(context).push(
                                              MaterialPageRoute(builder: (_) {
                                                if (item.food != '') {
                                                  return ProductScreen(
                                                    ProductData.fromDocument(
                                                        productsSnapshot
                                                            .documents
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
                  .toList() ,
                  
                  */
