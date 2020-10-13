import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /* 
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot.data["image"],
              fit: BoxFit.cover,
            ),
          ), */
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
                  '$rua, $compl, \n$ref, \n$bairro, \n$cidade, \n$estado',
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Ver no Mapa"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: () {},
              ),
              FlatButton(
                child: Text("Ligar"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: () {
                  launch("tel:${snapshot.data["phone"]}");
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
