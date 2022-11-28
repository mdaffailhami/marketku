import 'package:flutter/material.dart';

import 'pages/tambah_produk/tambah_produk.dart';

class MyTambahProdukButton extends StatelessWidget {
  const MyTambahProdukButton({super.key});

  static final isExtended = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isExtended,
      builder: (context, value, child) {
        return FloatingActionButton.extended(
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
          icon: Padding(
            padding: EdgeInsets.only(left: value ? 0 : 4),
            child: const Icon(Icons.add),
          ),
          extendedIconLabelSpacing: value ? 8 : 0,
          // label: Text('Tambah Produk'),
          label: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                child: child,
              ),
            ),
            child: value ? const Text("Tambah Produk") : null,
          ),
        );
      },
    );
  }
}
