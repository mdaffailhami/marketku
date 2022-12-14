import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketku/utils.dart';
import 'package:marketku/pages/sign_in/sign_in.dart';

import '../../pencarian.dart';
import 'pages/barang/barang.dart';
import 'pages/jasa/jasa.dart';

class MyHasilPencarianPage extends StatefulWidget {
  const MyHasilPencarianPage({
    super.key,
    required this.kataKunci,
  });

  final List<String> kataKunci;

  @override
  State<MyHasilPencarianPage> createState() => _MyHasilPencarianPageState();
}

class _MyHasilPencarianPageState extends State<MyHasilPencarianPage>
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

  void cariProduk() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MyPencarianPage(
          initial: joinKataKunci(widget.kataKunci),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const MySignInPage();
    }

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              shape: Border(
                bottom: BorderSide(
                  width: 0.2,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              titleSpacing: 0,
              title: InkWell(
                onTap: () => cariProduk(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: kToolbarHeight,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: NavigationToolbar.kMiddleSpacing),
                      child: Text(
                        joinKataKunci(widget.kataKunci),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => cariProduk(),
                  icon: const Icon(Icons.search),
                ),
                const SizedBox(width: 8),
              ],
              bottom: TabBar(
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
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            MyBarangPage(kataKunci: widget.kataKunci),
            MyJasaPage(kataKunci: widget.kataKunci),
          ],
        ),
      ),
    );
  }
}
