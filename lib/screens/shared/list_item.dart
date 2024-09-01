import 'package:flutter/material.dart';
import 'package:shepherd_voice/global/constants/design_constants.dart';

import '../../global/extensions/shadow_ext.dart';
import '../../global/extensions/text_style_ext.dart';

class ListItem extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget icon;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const ListItem({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(0),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyleExt.scada(
                      textStyle: TextStyle(
                        color: titleColor,
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
                  minHeight: 75,
                  minWidth: 75,
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
            ],
          ),
        ),
      ),
    );
  }
}
