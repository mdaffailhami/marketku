import 'package:flutter/material.dart';

import 'pages/barang/barang.dart';
import 'pages/jasa/jasa.dart';

class MyMarketKuPage extends StatelessWidget {
  const MyMarketKuPage({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        MyBarangPage(),
        MyJasaPage(),
      ],
    );
  }
}
