import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_library.dart' show BuildContext, ButtonThemeData, ChangeNotifier, Color, Colors, TextStyle, TextTheme, ThemeData, Brightness;

bool isDarkTheme = false;
BaseColorData? _theme = BaseColorData();

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    isDarkTheme = value;
    BaseColor.setColor();
    notifyListeners();
  }
}

class BaseColor {
  static BaseColorData? get theme => _theme;
  static setColor() {
    _theme = BaseColorData(
      buttonColor: isDarkTheme ? const Color(0xffffffff) : const Color(0xff0077bd),
      successColor: isDarkTheme ? const Color(0xff41B53E) : const Color(0xff41B53E),
      warningColor: const Color(0xffFFBDAE),
      yellowColor: const Color(0xffFFEA79),
      backgroundColor: const Color(0xffffffff),
      borderColor: const Color(0xffE4DFDF),
      linkActive: const Color(0xff046ede),
      primaryColor: const Color(0xff00A3FF),
      textButtonColor: const Color(0xffffffff),
      captionColor: const Color(0xff716E90),
      mutedColor: const Color(0xffbababa),
    );
  }
}

ThemeData themeDatas(bool isDarkTheme, BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
    ),
    scaffoldBackgroundColor: isDarkTheme == true ? const Color(0xff272727) : const Color(0xffffffff),
    backgroundColor: isDarkTheme == true ? const Color(0xff272727) : const Color(0xffffffff),
    cardColor: isDarkTheme == true ? const Color(0xff3E3E3E) : const Color(0xffffffff),
    textTheme: TextTheme(
//       button: isDarkTheme == true
//           ? const TextStyle(
//               color: Color(0xffffffff),
//             )
//           : const TextStyle(
//               color: Color(0xffffffff),
//             ),
      bodyText2: isDarkTheme == true
          ? GoogleFonts.poppins(
              textStyle: const TextStyle(color: Color(0xffffffff)),
            )
          : GoogleFonts.poppins(
              textStyle: const TextStyle(color: Color(0xff120D26)),
            ),
//       caption: isDarkTheme == true
//           ? const TextStyle(color: Color(0xffD7D7D7), fontSize: 10, fontWeight: FontWeight.w400)
//           : const TextStyle(
//               color: Color(0xff9B9B9B),
//               fontSize: 10,
//               fontWeight: FontWeight.w400,
//             ),
//       bodyText1: isDarkTheme == true
//           ? const TextStyle(
//               color: Color(0xffffffff),
//             )
//           : const TextStyle(
//               color: Color(0xffffffff),
//             ),
//       headline1: isDarkTheme == true
//           ? const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Color(0xffffffff),
//             )
//           : const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w500,
//               color: Color(0xff4D4D4D),
//             ),
//       headline2: isDarkTheme == true
//           ? const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: Color(0xffffffff),
//             )
//           : const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: Color(0xff4D4D4D),
//             ),
//       overline: isDarkTheme == true
//           ? const TextStyle(
//               fontSize: 20,
//               color: Color(0xffffffff),
//             )
//           : const TextStyle(
//               fontSize: 20,
//               color: Color(0xff4D4D4D),
//             ),
//       subtitle1: isDarkTheme == true
//           ? const TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w300,
//               color: Color(0xffffffff),
//             )
//           : const TextStyle(
//               fontSize: 11,
//               fontWeight: FontWeight.w300,
//               color: Color(0xff4D4D4D),
//             ),
      subtitle2: isDarkTheme == true
          ? GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 12, color: Color(0xffffffff)),
            )
          : GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 12, color: Color(0xff747688)),
            ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xffDC5B24),
    ),
    dividerColor: isDarkTheme == true ? const Color(0xffD7D7D7) : const Color(0xff9B9B9B),
    primaryColor: const Color(0xff046ede),
    errorColor: isDarkTheme == true ? const Color(0xffAD2E2E) : const Color(0xffAD2E2E),
    primarySwatch: isDarkTheme == true ? Colors.blue : Colors.blue,
    brightness: isDarkTheme == true ? Brightness.dark : Brightness.light,
    splashColor: Colors.black26,
  );
}

class BaseColorData {
  Color? buttonColor, successColor, warningColor, yellowColor, backgroundColor, borderColor, linkActive, primaryColor, textButtonColor, captionColor, mutedColor;

  BaseColorData({
    this.buttonColor,
    this.successColor,
    this.warningColor,
    this.yellowColor,
    this.backgroundColor,
    this.borderColor,
    this.linkActive,
    this.primaryColor,
    this.textButtonColor,
    this.captionColor,
    this.mutedColor,
  });
}
