import 'package:url_launcher/url_launcher.dart';

class WhatsAppApi {
  ///Implementar esta função corretamente!
  abrirWhatsApp() async {
    var whatsappUrl =
        "whatsapp://send?phone=+5586994324465&text=Olá,tudo bem ?";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
