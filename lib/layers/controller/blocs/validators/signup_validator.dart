import 'dart:async';

class SignUpValidator {
  StreamTransformer<String, String> validateConfirmPassword(String password1) {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (password2, sink) {
        if (password2.compareTo(password1) != 0) {
          return sink.addError("Senhas não iguais!");
        } else {
          return sink.add(password2);
        }
      },
    );
  }

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 6 && name.contains(' ')) {
      sink.add(name);
    } else {
      sink.addError("Insira nome completo!");
    }
  });

  final validateNameStore =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 5) {
      sink.add(name);
    } else {
      sink.addError("Insira nome comercial!");
    }
  });

  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.contains(
        RegExp(r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$'))) {
      sink.add(phone);
    } else {
      sink.addError("Insira um celular válido!");
    }
  });
}
