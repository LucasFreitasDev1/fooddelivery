import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonCategory extends StatelessWidget {
  const ButtonCategory({Key key, this.imgUrl}) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        child: CachedNetworkImage(imageUrl: imgUrl, imageBuilder: (context, img)=> CircularProgressIndicator(), ),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
