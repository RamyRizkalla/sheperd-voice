import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyleExt on TextStyle {
  static TextStyle scada({required TextStyle textStyle}) {
    return GoogleFonts.scada(textStyle: textStyle);
  }
}
