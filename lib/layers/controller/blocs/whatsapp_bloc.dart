import 'package:url_launcher/url_launcher.dart';

class WhatsAppApi {
  ///Implementar esta função corretamente!
  static abrirWhatsApp(String number) async {
    var whatsappUrl =
        Uri.parse("whatsapp://send?phone=+55${number.toString()}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
