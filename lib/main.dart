import 'package:flutter/material.dart';

import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF0463F1);

    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: seedColor,
    );

    final darkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: seedColor,
    );

    final theme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.background,
      colorScheme: colorScheme,
      dialogBackgroundColor: colorScheme.background,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      textTheme: TextTheme(
        displaySmall: TextStyle(color: colorScheme.onBackground),
        displayMedium: TextStyle(color: colorScheme.onBackground),
        displayLarge: TextStyle(color: colorScheme.onBackground),
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkColorScheme.background,
      colorScheme: darkColorScheme,
      dialogBackgroundColor: darkColorScheme.background,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      textTheme: TextTheme(
        displaySmall: TextStyle(color: darkColorScheme.onBackground),
        displayMedium: TextStyle(color: darkColorScheme.onBackground),
        displayLarge: TextStyle(color: darkColorScheme.onBackground),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MarketKu',
      themeMode: ThemeMode.system,
      theme: theme,
      darkTheme: darkTheme,
      home: MySplashScreen(
        duration: Duration(seconds: 2),
        home: Text('HOME'),
      ),
    );
  }
}
