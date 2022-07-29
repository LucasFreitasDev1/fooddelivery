String formatHours(int hour, int minute) {
  String hora = hour >= 10 ? hour.toString() : '0' + hour.toString();
  String minutos = minute >= 10 ? minute.toString() : '0' + minute.toString();

  return hora + ':' + minutos;
}

String formatNumberwihtZero(
  int number,
) {
  String numberFormat =
      number >= 10 ? number.toString() : '0' + number.toString();
  return numberFormat;
}

getMes(int mes) {
  switch (mes) {
    case 1:
      return 'Janeiro';
    case 2:
      return 'Feveiro';
    case 3:
      return 'Março';
    case 4:
      return 'Abril';
    case 5:
      return 'Maio';
    case 6:
      return 'Junho';
    case 7:
      return 'Julho';
    case 8:
      return 'Agosto';
    case 9:
      return 'Setembro';
    case 10:
      return 'Outubro';
    case 11:
      return 'Novembro';
    case 12:
      return 'Dez';
  }
}
