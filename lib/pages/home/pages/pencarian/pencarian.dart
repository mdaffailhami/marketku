import 'package:flutter/material.dart';
import 'package:marketku/pages/home/pages/pencarian/utils.dart';

import 'pages/hasil_pencarian/hasil_pencarian.dart';

class MyPencarianPage extends StatefulWidget {
  const MyPencarianPage({
    super.key,
    this.initial,
  });

  final String? initial;

  @override
  State<MyPencarianPage> createState() => _MyPencarianPageState();
}

class _MyPencarianPageState extends State<MyPencarianPage> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.initial);
  }

  void cariProduk({required String kataKunci}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            MyHasilPencarianPage(kataKunci: splitKataKunci(kataKunci)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            width: 0.2,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Kembali',
        ),
        actions: [
          Visibility(
            visible: searchController.text.isNotEmpty,
            child: IconButton(
                onPressed: () => setState(() => searchController.clear()),
                icon: const Icon(Icons.close)),
          ),
          const SizedBox(width: 6),
        ],
        title: TextField(
          controller: searchController,
          onChanged: ((_) => setState(() {})),
          autofocus: true,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.text,
          onSubmitted: (_) => cariProduk(kataKunci: searchController.text),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
            hintText: 'Cari Barang atau Jasa',
          ),
        ),
      ),
      body: Visibility(
        visible: searchController.text.isNotEmpty,
        child: Builder(
          builder: (_) {
            List<Widget> children = [];

            final keywords = splitKataKunci(searchController.text);

            for (int i = 0; i < keywords.length; i++) {
              var text = '';
              for (int j = 0; j <= i; j++) {
                text += keywords[j];

                if (j != i) text += ' ';
              }

              children.add(
                ListTile(
                  onTap: () => cariProduk(kataKunci: text),
                  leading: const Icon(Icons.search),
                  title: Text(text),
                ),
              );
            }

            children.add(
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            );

            return Column(children: children);
          },
        ),
      ),
    );
  }
}
