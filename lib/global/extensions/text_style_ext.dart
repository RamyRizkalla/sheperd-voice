import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyleExt on TextStyle {
  static TextStyle notoSansArabic({required TextStyle textStyle}) {
    return GoogleFonts.notoSansArabic(textStyle: textStyle);
  }

  static TextStyle scheherazadeNew({required TextStyle textStyle}) {
    return GoogleFonts.scheherazadeNew(textStyle: textStyle);
  }
}
