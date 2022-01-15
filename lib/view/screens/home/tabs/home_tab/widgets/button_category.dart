import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonCategory extends StatefulWidget {
  

  ButtonCategory({Key key, @required this.imgUrl, @required this.onTap});

  final String imgUrl;
  final Function onTap;

  @override
  _ButtonCategoryState createState() => _ButtonCategoryState(imgUrl, onTap);
}

class _ButtonCategoryState extends State<ButtonCategory> {
  _ButtonCategoryState(this._img, this.onTap);

  String _img;
  Stream _ref;
  Function onTap;

  @override
  initState() {
    super.initState();
    _ref = FirebaseStorage().getReferenceFromUrl(_img).asStream();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        splashColor: Theme.of(context).primaryColor,
        child: StreamBuilder<StorageReference>(
          stream: _ref,
          builder: (context, ref) {
            if (ref.hasData)
              return FutureBuilder(
                  initialData: '',
                  future: ref.data.getDownloadURL(),
                  builder: (context, snapshot) {
                    log(snapshot.data?.toString());

                    if (snapshot.hasData)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data.toString(),
                        ),
                      );
                    return Container(
                      color: Colors.grey,
                    );
                  });
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}