import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreenTitleBox extends StatelessWidget {
  final String title;

  const MainScreenTitleBox({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: (MediaQuery.of(context).size.width / 1.5)),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white70,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.scheherazadeNew(
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                height: 1.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
