import 'package:url_launcher/url_launcher.dart';

class WhatsAppApi {
  ///Implementar esta função corretamente!
  static abrirWhatsApp(String number) async {
    String whatsappUrl =
        "whatsapp://send?phone=+55${number.toString()}";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
