import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/productData.dart';
import 'package:food_delivery_app/view/tiles/product_tile.dart';

enum ItemsDisplay { full, trendings }

class ListProductInitial extends StatefulWidget {
  @override
  _ListProductInitialState createState() => _ListProductInitialState();
}

class _ListProductInitialState extends State<ListProductInitial> {
  ItemsDisplay _selectDisplay = ItemsDisplay.full;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('products').getDocuments(),
        builder: (context, products) {
          if (!products.hasData)
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          else {
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
                              Scaffold.of(context).showBottomSheet((context) {
                                return BottomSheet(
                                    elevation: 45,
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    onClosing: () {},
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
                                                      Duration(
                                                          milliseconds: 300),
                                                      () {
                                                    Navigator.pop(context);
                                                  });
                                                });
                                              })

                                          /* Radio(
                                          value: SingingCharacter.lafayette,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter value) {
                                            setState(() { _character = value; });
                                          },
                                        ), */
                                        ],
                                      );
                                    });
                              });
                            }),
                      ),
                    ],
                  ),
                  _selectDisplay == ItemsDisplay.full
                      ? buildGridView(products.data)
                      : buildGridView(products.data)
                ],
              ),
            );
          }
        });
  }

  GridView buildGridView(QuerySnapshot products) {
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
        itemCount: products.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot doc = products.documents.elementAt(index);
          ProductData data = ProductData.fromDocument(doc);
          data.category = doc.data['category'];
          return ProductTile(data);
        });
  }
}
