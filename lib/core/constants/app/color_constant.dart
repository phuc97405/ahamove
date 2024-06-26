import 'package:flutter/material.dart';

class ColorConstants {
  static ColorConstants? _instance;
  static ColorConstants get instance {
    _instance ??= ColorConstants._init();
    return _instance!;
  }

  ColorConstants._init();

  Color black0B = const Color(0xff090A0B);
  Color green = const Color(0xff00C73C);
  Color primary = const Color(0xff811C37);
  Color primaryDefault = const Color(0xffef3465);
  Color primaryDisable = const Color(0xffC4C6CD);
  Color onPrimary = const Color(0xff628941);
  Color teal = const Color(0xff37A492);
  Color bgGoogle = const Color(0xffEAEAEA);
  Color red = const Color(0xffFA3152);
  Color border = const Color(0xffE1E2E5);
  Color aliceBlue = const Color(0xFFF1F2F3);
  Color error700 = const Color(0xFFA9122B);
  Color redButtonEF = const Color(0xFFEF3465);
  Color blackDes38 = const Color(0xFF383B45);
  Color disabledBtn = const Color(0xFFC4C6CD);
  Color gray62 = const Color(0xFF626576);
  Color bgColor = const Color(0xFFF5F6F7);
}
