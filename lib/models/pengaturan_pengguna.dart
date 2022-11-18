import 'package:flutter/material.dart';

enum ThemeMode { system, light, dark }

class PengaturanPengguna {
  PengaturanPengguna({
    this.themeMode,
    this.seedColor,
  });

  ThemeMode? themeMode;
  Color? seedColor;
}
