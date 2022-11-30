import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketku/pages/home/home.dart';
import 'package:marketku/pages/sign_in/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'models/pengguna.dart';
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
  static final themeMode = ValueNotifier(ThemeMode.system);
  static final seedColor = ValueNotifier(const Color(0xFF3120E0));
  static Pengguna? pengguna;

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      prefs = value;

      final userThemeMode = prefs!.getString('theme_mode');
      final userSeedColor = prefs!.getString('seed_color');

      if (userThemeMode != null) {
        themeMode.value = ThemeMode.values
            .where((element) => element.name == userThemeMode)
            .toList()[0];
      }

      if (userSeedColor != null) {
        seedColor.value = Color(int.parse('0x$userSeedColor'));
      }
    });

    return const MyMaterialApp();
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MyApp.themeMode,
      builder: (_, themeMode, ___) {
        return ValueListenableBuilder(
          valueListenable: MyApp.seedColor,
          builder: (_, seedColor, ___) {
            final colorScheme = ColorScheme.fromSeed(
              brightness: Brightness.light,
              seedColor: MyApp.seedColor.value,
            );

            final darkColorScheme = ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: MyApp.seedColor.value,
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
              themeMode: themeMode,
              theme: theme,
              darkTheme: darkTheme,
              home: MySplashScreen(
                duration: const Duration(seconds: 2),
                home: Builder(
                  builder: (_) {
                    final user = FirebaseAuth.instance.currentUser;

                    // Jika tidak ada user yang signed in atau ada user tapi belum verifikasi
                    if (user == null || !user.emailVerified) {
                      return const MySignInPage();
                    }

                    return FutureBuilder(
                      future: Pengguna.getById(
                          FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Scaffold(
                            body: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        MyApp.pengguna = snapshot.data;

                        return const MyHomePage();
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
