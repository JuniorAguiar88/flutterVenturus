import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeModel extends ChangeNotifier {
  bool isDark = false;
  MyTheme myTheme = MyTheme(color: Color.fromARGB(255, 27, 3, 247));
  ThemeData get customTheme => myTheme.customTheme;
  ThemeData get themeMode =>
      isDark ? myTheme.customThemeDark : myTheme.customTheme;

  get customThemeDark => null;

  void swicthTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}

class MyTheme {
  Color color;

  late ColorScheme colorScheme;
  late ColorScheme colorSchemeDark;
  late ThemeData customTheme;
  late ThemeData customThemeDark;

  MyTheme({required this.color}) {
    colorScheme = ColorScheme.fromSeed(
      seedColor: color, // Usa o azul como cor principal
      brightness: Brightness.light, // Define brilho para tema claro
    );

    // Configura o tema ESCURO:
    colorSchemeDark = ColorScheme.fromSeed(
      seedColor: color, // Mesmo azul, mas adaptado ao escuro
      brightness: Brightness.dark, // Define brilho para tema escuro
    );

    customTheme = ThemeData(
      //tema claro
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.lato().fontFamily,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: colorScheme.tertiary,
        titleTextStyle: GoogleFonts.lobster(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: colorScheme.onTertiary,
        ),
        actionsIconTheme: IconThemeData(color: colorScheme.onTertiary),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.secondaryContainer,
        shadowColor: colorScheme.onSurface,
        elevation: 7,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

    customThemeDark = ThemeData(
      //tema escuro
      colorScheme: colorSchemeDark,
      fontFamily: GoogleFonts.lato().fontFamily,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: colorSchemeDark.onTertiary,
        titleTextStyle: GoogleFonts.lobster(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: colorSchemeDark.tertiary,
        ),
        actionsIconTheme: IconThemeData(color: colorSchemeDark.tertiary),
      ),
      cardTheme: CardThemeData(
        color: colorSchemeDark.secondaryContainer,
        shadowColor: colorSchemeDark.onSurface,
        elevation: 7,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
