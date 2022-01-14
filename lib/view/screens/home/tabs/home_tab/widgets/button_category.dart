import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonCategory extends StatefulWidget {
  ButtonCategory({Key key, @required this.imgUrl});

  final String imgUrl;

  @override
  _ButtonCategoryState createState() => _ButtonCategoryState(imgUrl);
}

class _ButtonCategoryState extends State<ButtonCategory> {
  _ButtonCategoryState(this._img);

  String _img;


  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(30)),
      child: FutureBuilder (
        initialData: '',
        future: FirebaseStorage(storageBucket: _img).ref().getDownloadURL(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
          return InkWell(
          onTap: () {},
          splashColor: Theme.of(context).primaryColor,
          child: CachedNetworkImage(
            imageUrl: snapshot.data?.toString()
            ,
            imageBuilder: (context, img) => CircularProgressIndicator(),
          ),
        );
        return CircularProgressIndicator();
        },
      ),
    );
  }
}
