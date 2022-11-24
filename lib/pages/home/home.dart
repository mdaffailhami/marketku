import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketku/pages/sign_in/sign_in.dart';

import 'app_bar.dart';
import 'nav_bar.dart';
import 'pages/beranda/beranda.dart';
import 'pages/marketku/tambah_produk_button.dart';
import 'pages/marketku/marketku.dart';
import 'pages/pesan/pesan.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentPageIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const MySignInPage();
    }

    return Scaffold(
      floatingActionButton:
          currentPageIndex == 1 ? const MyTambahProdukButton() : null,
      bottomNavigationBar: MyNavBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int value) {
          setState(() {
            currentPageIndex = value;
          });
        },
      ),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            MyAppBar(
              showTabBar: currentPageIndex != 2,
              tabController: tabController,
              searchBarHint: currentPageIndex == 2
                  ? 'Cari Pengguna'
                  : 'Cari Barang atau Jasa',
            ),
          ];
        },
        body: [
          MyBerandaPage(
            tabController: tabController,
          ),
          MyMarketKuPage(tabController: tabController),
          const MyPesanPage(),
        ][currentPageIndex],
      ),
    );
  }
}
