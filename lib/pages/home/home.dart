import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketku/pages/sign_in/sign_in.dart';

import 'app_bar.dart';
import 'nav_bar.dart';
import 'pages/beranda/beranda.dart';
import 'pages/marketku/tambah_produk_button.dart';
import 'pages/marketku/marketku.dart';
import 'pages/favorit/favorit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.initialPageIndex = 0});

  final int initialPageIndex;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currentPageIndex;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    currentPageIndex = widget.initialPageIndex;
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
              showTabBar: true,
              tabController: tabController,
              searchBarHint: 'Cari Barang atau Jasa',
            ),
          ];
        },
        body: [
          MyBerandaPage(tabController: tabController),
          MyMarketKuPage(tabController: tabController),
          MyFavoritPage(tabController: tabController),
        ][currentPageIndex],
      ),
    );
  }
}
