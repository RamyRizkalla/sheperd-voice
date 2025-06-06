import 'package:flutter/material.dart';

import '../../global/constants/design_constants.dart';
import '../../global/extensions/shadow_ext.dart';
import '../../global/extensions/text_style_ext.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const HomeButton({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(DesignConstants.defaultCornerRadius),
        ),
        boxShadow: [BoxShadowExt.defaultShadow()],
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(DesignConstants.defaultCornerRadius),
          ),
        ),
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(DesignConstants.defaultCornerRadius),
              ),
            ),
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    maxLines: 3,
                    style: TextStyleExt.notoSansArabic(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        shadows: [ShadowExt.textShadow()],
                      ),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 60,
                  minWidth: 60,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        DesignConstants.defaultCornerRadius,
                      ),
                    ),
                  ),
                  child: SizedBox(width: 50, height: 50, child: icon),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
