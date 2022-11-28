import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketku/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static SharedPreferences? prefs;
  static var themeMode = ValueNotifier<ThemeMode>(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      prefs = value;

      final userThemeMode = MyApp.prefs!.getString('theme_mode');

      if (userThemeMode != null) {
        themeMode.value = ThemeMode.values
            .where((element) => element.name == userThemeMode)
            .toList()[0];
      }
    });

    return const MyMaterialApp();
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

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

    return ValueListenableBuilder(
      valueListenable: MyApp.themeMode,
      builder: (_, themeMode, ___) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MarketKu',
          themeMode: themeMode,
          theme: theme,
          darkTheme: darkTheme,
          home: const MySplashScreen(
            duration: Duration(seconds: 2),
            home: MyHomePage(),
          ),
        );
      },
    );
  }
}
