import 'package:flutter/material.dart';

import 'pages/barang/barang.dart';
import 'pages/jasa/jasa.dart';

class MyFavoritPage extends StatelessWidget {
  const MyFavoritPage({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        MyBarangPage(),
        MyJasaPage(),
      ],
    );
  }
}
