import 'package:flutter/material.dart';

extension ShadowExt on Shadow {
  static Shadow textShadow() {
    return Shadow(
      offset: const Offset(0, 4),
      blurRadius: 4.0,
      color: Colors.black.withOpacity(0.25),
    );
  }
}

extension BoxShadowExt on BoxShadow {
  static BoxShadow defaultShadow() {
    return BoxShadow(
      color: Colors.black.withOpacity(0.25),
      blurRadius: 4.0,
      offset: const Offset(0, 4),
    );
  }
}
