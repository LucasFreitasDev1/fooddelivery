import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/blocs/whatsapp_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../widgets/button_default.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    String rua = snapshot.data['address']['rua'];
    String compl = snapshot.data['address']['complemento'];
    String ref = snapshot.data['address']['referencia'];
    String bairro = snapshot.data['address']['bairro'];
    String cidade = snapshot.data['address']['cidade'];
    String estado = snapshot.data['address']['estado'];
    final String number = snapshot.data["phone"];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data["titleStore"],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                Text(
                  '$rua, $compl, \n$ref, $bairro, $cidade, $estado',
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DefaultButton(
                  color: Colors.transparent,
                  child: Text(
                    "Ver WhatsApp",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () => WhatsAppApi.abrirWhatsApp(number)),
              DefaultButton(
                color: Colors.transparent,
                child: Text(
                  "Ligar",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  launch("tel:$number");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
