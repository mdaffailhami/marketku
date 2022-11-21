import 'package:flutter/material.dart';

import 'daftar_jasa.dart';
import 'daftar_kategori.dart';

class MyJasaPage extends StatelessWidget {
  const MyJasaPage({super.key});

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
            MyDaftarJasa(),
          ],
        ),
      ),
    );
  }
}
