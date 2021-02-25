import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static Color mainColor = Color(0xFF1a237e);
  static Color secondColor = Color(0xFF1a237e);
  static Color grey = Color(0xFFE5E5E5);
  static Color background = Color(0xFFf0f1f6);
  static Color titleColor = Color(0xFF1a237e);
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF1a237e), Color(0xFF534bae)],
    stops: [0.0, 1.0],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
