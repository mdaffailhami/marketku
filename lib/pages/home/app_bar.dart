import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as lol;
import 'package:marketku/main.dart';
import 'package:marketku/pages/home/home.dart';
import 'package:marketku/pages/home/pages/profil/profil.dart';
import 'package:marketku/widgets/marketku_logotype.dart';

import 'pages/pencarian/pencarian.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.showTabBar,
    required this.tabController,
    required this.searchBarHint,
  }) : super(key: key);

  final bool showTabBar;
  final TabController tabController;
  final String searchBarHint;
  final String urlFotoProfilDefault =
      'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=170x170&k=20&c=pVkxcoiVUlD0uOzasLU41qdrAQpT1B3vBfKSJQWuNq4=';

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: showTabBar,
      floating: true,
      centerTitle: true,
      title: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MyPencarianPage()),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
          fixedSize: Size(
            MediaQuery.of(context).size.width - 20,
            46,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 2),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const MyPencarianPage()),
                );
              },
              icon: const Icon(Icons.search),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                searchBarHint,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                                Center(
                                    child: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? MyMarketKuLogotype.light(fontSize: 20)
                                        : MyMarketKuLogotype.dark(
                                            fontSize: 20)),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(Duration.zero).then((_) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const MyProfilPage(),
                                  ),
                                );
                              });
                            },
                            child: () {
                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                leading: CircleAvatar(
                                  radius: 18,
                                  foregroundImage: NetworkImage(
                                    MyApp.pengguna!.urlFotoProfil ??
                                        urlFotoProfilDefault,
                                  ),
                                ),
                                minLeadingWidth: 40 - 5,
                                title: Text(MyApp.pengguna!.nama),
                                subtitle: Text(MyApp.pengguna!.alamatEmail),
                              );
                            }(),
                          ),
                          const Divider(),
                          PopupMenuItem(
                            onTap: () async {
                              await Future.delayed(
                                const Duration(seconds: 0),
                              );

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Pilih tema aplikasi'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Batal'),
                                      )
                                    ],
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        3,
                                        (i) {
                                          ThemeMode themeMode;
                                          if (i == 0) {
                                            themeMode = ThemeMode.light;
                                          } else if (i == 1) {
                                            themeMode = ThemeMode.dark;
                                          } else {
                                            themeMode = ThemeMode.system;
                                          }

                                          return RadioListTile<ThemeMode>(
                                            value: themeMode,
                                            groupValue: MyApp.themeMode.value,
                                            onChanged: (value) {
                                              MyApp.prefs!.setString(
                                                  'theme_mode', value!.name);

                                              MyApp.themeMode.value = value;
                                              Navigator.of(context).pop();
                                            },
                                            title: Builder(builder: (_) {
                                              if (themeMode ==
                                                  ThemeMode.light) {
                                                return const Text('Terang');
                                              } else if (themeMode ==
                                                  ThemeMode.dark) {
                                                return const Text('Gelap');
                                              } else {
                                                return const Text('Sistem');
                                              }
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Builder(
                                  builder: (_) {
                                    final isOnDarkMode =
                                        MyApp.themeMode.value ==
                                                ThemeMode.dark ||
                                            (MyApp.themeMode.value ==
                                                    ThemeMode.system &&
                                                MediaQuery.of(context)
                                                        .platformBrightness ==
                                                    Brightness.dark);

                                    if (isOnDarkMode) {
                                      return const Icon(
                                          Icons.dark_mode_outlined);
                                    } else {
                                      return const Icon(
                                          Icons.light_mode_outlined);
                                    }
                                  },
                                ),
                                const SizedBox(width: 8),
                                const Text('Tema Aplikasi'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              await Future.delayed(
                                const Duration(seconds: 0),
                              );

                              showDialog(
                                  context: context,
                                  builder: (context) => const MyColorPicker());
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.color_lens_outlined),
                                SizedBox(width: 8),
                                Text('Warna Aplikasi'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const MyHomePage(),
                                ),
                              );
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.logout, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Keluar'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: CircleAvatar(
                radius: 18,
                foregroundImage: NetworkImage(
                  MyApp.pengguna!.urlFotoProfil ?? urlFotoProfilDefault,
                ),
              ),
            ),
          ],
        ),
      ),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      shape: Border(
        bottom: BorderSide(
          width: 0.2,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      bottom: showTabBar
          ? TabBar(
              controller: tabController,
              labelColor: Theme.of(context).colorScheme.onBackground,
              indicatorColor: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.primary,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'Barang'),
                Tab(text: 'Jasa'),
              ],
            )
          : null,
    );
  }
}

class MyColorPicker extends StatefulWidget {
  const MyColorPicker({Key? key}) : super(key: key);

  @override
  State<MyColorPicker> createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  var pickedColor = MyApp.seedColor.value;

  @override
  Widget build(BuildContext context) {
    // lol.SlidePicker()
    return AlertDialog(
      title: const Text('Pilih warna aplikasi'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            MyApp.prefs!
                .setString('seed_color', pickedColor.value.toRadixString(16));

            MyApp.seedColor.value = pickedColor;

            Navigator.of(context).pop();
          },
          child: const Text('Pilih'),
        ),
      ],
      // contentPadding: EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: lol.ColorPicker(
          enableAlpha: false,
          hexInputBar: true,
          pickerColor: MyApp.seedColor.value,
          labelTypes: const [],
          onColorChanged: (value) {
            pickedColor = value;
          },
        ),
      ),
    );
  }
}
