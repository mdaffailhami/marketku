import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketku/pages/home/home.dart';
import 'package:marketku/models/pengguna.dart';
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
            FutureBuilder(
                future:
                    Pengguna.getById(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  final Pengguna pengguna = snapshot.data as Pengguna;

                  return IconButton(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 8, 4, 4),
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
                                              ? MyMarketKuLogotype.light(
                                                  fontSize: 20)
                                              : MyMarketKuLogotype.dark(
                                                  fontSize: 20)),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(onTap: () {
                                  Future.delayed(Duration.zero).then((_) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const MyProfilPage(),
                                      ),
                                    );
                                  });
                                }, child: () {
                                  if (!snapshot.hasData) {
                                    return const LinearProgressIndicator();
                                  }

                                  return ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    leading: CircleAvatar(
                                      radius: 18,
                                      foregroundImage: NetworkImage(
                                        pengguna.urlFotoProfil ??
                                            urlFotoProfilDefault,
                                      ),
                                    ),
                                    minLeadingWidth: 40 - 5,
                                    title: Text(pengguna.nama),
                                    subtitle: Text(pengguna.alamatEmail),
                                  );
                                }()),
                                const Divider(),
                                PopupMenuItem(
                                  child: Row(
                                    children: const [
                                      Icon(Icons.bookmark_outline),
                                      SizedBox(width: 8),
                                      Text('Favorit'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: const [
                                      Icon(Icons.settings_outlined),
                                      SizedBox(width: 8),
                                      Text('Pengaturan'),
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
                        pengguna.urlFotoProfil ?? urlFotoProfilDefault,
                      ),
                    ),
                  );
                }),
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
