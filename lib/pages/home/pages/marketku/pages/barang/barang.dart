import 'package:flutter/material.dart';

import 'daftar_barang.dart';
import 'daftar_kategori.dart';

class MyBarangPage extends StatelessWidget {
  const MyBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyDaftarKategori(),
            SizedBox(height: 4),
            MyDaftarBarang(),
          ],
        ),
      ),
    );
  }
}
