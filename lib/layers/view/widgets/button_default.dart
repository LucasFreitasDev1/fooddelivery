import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.onPressed,
    this.radius = 40,
    this.color = Colors.teal,
    this.child,
  }) : super(key: key);
/* 
   onPressed: _onpressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        color: Theme.of(context).primaryColor,
        splashColor: Colors.grey,
        textColor: Colors.white,
        child: Text('Salvar Dados e Conluir'),
 */
  final VoidCallback onPressed;
  final double radius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius), color: color),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
