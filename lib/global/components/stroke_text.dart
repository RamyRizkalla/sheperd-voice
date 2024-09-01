import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;

  const StrokeText(
    this.text, {
    super.key,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.scheherazadeNew(
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              foreground: Paint()
                ..strokeWidth = strokeWidth
                ..color = strokeColor
                ..style = PaintingStyle.stroke,
            ),
          ),
        ),
        Text(
          text,
          style: GoogleFonts.scheherazadeNew(
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              foreground: Paint()..color = color,
            ),
          ),
        ),
      ],
    );
  }
}
