import 'package:flutter/material.dart';
import 'package:marketku/widgets/banner.dart';

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
            const MyBanner(
              imageUrl:
                  'https://cdnwpseller.gramedia.net/wp-content/uploads/2021/08/19153353/Usaha-Jasa.jpg',
              text: 'Kami menyediakan berbagai jasa yang layak untuk anda!',
            ),
            const SizedBox(height: 12),
            Text(
              'Jasa populer saat ini',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            // MyDaftarKategori(),
            const SizedBox(height: 4),
            // MyDaftarJasa(),
          ],
        ),
      ),
    );
  }
}
