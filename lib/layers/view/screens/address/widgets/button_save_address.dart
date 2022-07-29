import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/screens/home/home_screen.dart';

import '../../../widgets/button_default.dart';

class ButtonSaveAddress extends StatelessWidget {
  final Function _save;
  ButtonSaveAddress(this._save);
  @override
  Widget build(BuildContext context) {
    void _onpressed() async {
      String error = await _save();
      error != ''
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                error,
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent,
            ))
          : Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
    }

    return SizedBox(
      height: 50,
      child: DefaultButton(
        onPressed: _onpressed,
        color: Theme.of(context).primaryColor,
        child: Text(
          'Salvar Dados e Conluir',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
