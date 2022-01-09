import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/tabs/home_tab/widgets/trendings_foods_heading.dart';

class TrendingsFoodsHome extends StatelessWidget {
  const TrendingsFoodsHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        
        TrendingsFoodsHeading(),

        /* 
        FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection('products').getDocuments(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              }
              if (snapshot.hasData) {
                var query = snapshot.data.documents;
                query.isEmpty
                    ? FoodsCarouselLoaderWidget()
                    : Container(
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: GridView.builder(
                          padding: EdgeInsets.all(4.0),
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: query.length,
                          itemBuilder: (context, index) {
                            return;
                          },
                          scrollDirection: Axis.vertical,
                        ));
              }
              return Container();
            }), 
            */

      ],
    );
  }
}
