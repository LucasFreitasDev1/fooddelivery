import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final bool done;

  InputField(
      {required this.icon,
      required this.hint,
      required this.obscure,
      required this.stream,
      required this.onChanged,
      required this.keyboardType,
      required this.done});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    final _maskPhone = TextInputMask(mask: '(##) #####-####');

    return StreamBuilder<String>(
        stream: widget.stream,
        builder: (context, snapshot) {
          return TextField(
            inputFormatters: widget.hint == 'Celular'
                ? [
                    _maskPhone,
                    LengthLimitingTextInputFormatter(15),
                  ]
                : null,
            textInputAction:
                widget.done ? TextInputAction.done : TextInputAction.next,
            onSubmitted: (value) {
              widget.done
                  ? FocusScope.of(context).unfocus()
                  : FocusScope.of(context).nextFocus();
            },
            keyboardType: widget.keyboardType != null
                ? widget.keyboardType
                : TextInputType.text,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon),
              hintText: widget.hint,
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            ),
            obscureText: widget.obscure,
          );
        });
  }
}
