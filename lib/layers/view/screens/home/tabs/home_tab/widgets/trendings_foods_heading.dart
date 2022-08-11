import 'package:flutter/material.dart';

class TrendingsFoodsHeading extends StatelessWidget {
  const TrendingsFoodsHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: Icon(
          Icons.trending_up,
          color: Theme.of(context).hintColor,
        ),
        title: Text(
          'Mais vendidos',
          style: Theme.of(context).textTheme.headline6,
        ),
        /* subtitle: Text(
          'Click para ver mais',
          maxLines: 2,
          style: Theme.of(context).textTheme.caption, 
        ),*/
      ),
    );
  }
}
