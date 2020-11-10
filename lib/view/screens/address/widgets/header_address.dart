import 'package:flutter/material.dart';

class HeaderAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* 
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Falta pouco...',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
          ),
        ), */
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Agora precisamos saber seu endereço' +
                ' para entrega dos seus pedidos. ' +
                '\nÉ muito importante você manter esses dados atualizados.',
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
