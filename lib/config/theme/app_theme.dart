import 'package:flutter/material.dart';

class AppTheme {
  //Metodo
  ThemeData getTheme() {
    const seedColor = Colors.black;

    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        listTileTheme: const ListTileThemeData(
          iconColor: seedColor,
        ));
  }
}
