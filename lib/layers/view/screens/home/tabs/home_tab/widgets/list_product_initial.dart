import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/layers/controller/home_controller.dart';
import 'package:food_delivery_app/shared/dependencies_injector.dart';

import '../../../../../../model/product_model.dart';
import '../../../../../tiles/product_tile.dart';

enum ItemsDisplay { full, trendings }

class ListProductInitial extends StatefulWidget {
  @override
  _ListProductInitialState createState() => _ListProductInitialState();
}

class _ListProductInitialState extends State<ListProductInitial> {
  ItemsDisplay _selectDisplay = ItemsDisplay.full;

  @override
  Widget build(BuildContext context) {
    final bloc = inject.get<HomeController>();

    return FutureBuilder<List<ProductModel>?>(
        future: bloc.getAllProductsHomePage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          else {
            var listProducts = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: _selectDisplay == ItemsDisplay.full
                            ? Text('Todos os produtos')
                            : Text('Mais vendidos'),
                      ),
                      Container(
                        child: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              /* 
        Scaffold.of(context).showBottomSheet((context) {
          return BottomSheet(
              elevation: 45,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20))),
              onClosing: Navigator.of(context).pop,
              builder: (_) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RadioListTile(
                        title: Text('Todos os produtos'),
                        value: ItemsDisplay.full,
                        groupValue: _selectDisplay,
                        onChanged: (ItemsDisplay value) {
                          setState(() {
                            _selectDisplay = value;
                            Future.delayed(
                                Duration(
                                    milliseconds: 300),
                                () {
                              Navigator.pop(context);
                            });
                          });
                        }),
                    RadioListTile(
                      title: Text('Mais vendidos'),
                      value: ItemsDisplay.trendings,
                      groupValue: _selectDisplay,
                      onChanged: (ItemsDisplay value) {
                        setState(() {
                          _selectDisplay = value;
                          Future.delayed(
                              Duration(milliseconds: 300),
                              () {
                            Navigator.pop(context);
                          });
                        });
                      },
                    ),
                  ],
                );
              });
        }); */
                            }),
                      ),
                    ],
                  ),
                  _selectDisplay == ItemsDisplay.full
                      ? buildGridView(listProducts)
                      : buildGridView(listProducts)
                ],
              ),
            );
          }
        });
  }

  GridView buildGridView(List<ProductModel> products) {
    return GridView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.9,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          //  DocumentSnapshot doc = products.documents.elementAt(index);
          ProductModel data = products.elementAt(index);
          // ProductModel.fromDocument(doc);
          //   data.category = doc.data['category'];
          return ProductTile(data);
        });
  }
}
