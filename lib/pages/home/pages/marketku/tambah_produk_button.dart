import 'package:flutter/material.dart';

import 'pages/tambah_produk/tambah_produk.dart';

class MyTambahProdukButton extends StatelessWidget {
  const MyTambahProdukButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).colorScheme.onPrimaryContainer
          : Theme.of(context).colorScheme.onPrimary,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MyTambahProdukPage(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
