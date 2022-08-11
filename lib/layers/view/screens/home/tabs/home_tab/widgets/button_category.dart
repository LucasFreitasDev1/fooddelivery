import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/shared/dependencies_injector.dart';

import '../../../../../../controller/home_controller.dart';

class ButtonCategory extends StatelessWidget {
  ButtonCategory({Key? key, required this.imgUrl, required this.onTap});

  final String imgUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final home = inject.get<HomeController>();
    return Container(
      width: 62,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.grey), //Theme.of(context).primaryColor
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onTap,
          splashColor: Theme.of(context).primaryColor,
          child: FutureBuilder<String>(
              initialData: '',
              future: home.getImageCategory(imgUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!,
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }
}
