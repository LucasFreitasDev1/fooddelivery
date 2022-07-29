import 'package:flutter/widgets.dart';

class Sizes {
  static double? widhtAdaptive(BuildContext context) =>
      MediaQuery.of(context).size.width > 490 ? 490.0 : null;

  static double? heightAdaptive(BuildContext context) =>
      MediaQuery.of(context).size.height < 650 ? 650.0 : null;

  static bool isBigSize(context) => MediaQuery.of(context).size.width > 499;
}
