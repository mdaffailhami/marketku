import 'package:flutter/material.dart';
import 'package:marketku/widgets/banner.dart';
import 'package:marketku/models/barang.dart';
import 'package:marketku/widgets/choice_chip.dart';
import 'package:marketku/widgets/produk_card.dart';

class MyBarangPage extends StatefulWidget {
  const MyBarangPage({super.key});

  @override
  State<MyBarangPage> createState() => _MyBarangPageState();
}

class _MyBarangPageState extends State<MyBarangPage> {
  int selectedKategoriIndex = -1;

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
                  'https://c0.wallpaperflare.com/preview/250/807/592/person-human-market-shop.jpg',
              text: 'Kami menyediakan berbagai barang yang layak untuk anda!',
            ),
            const SizedBox(height: 12),
            Text(
              'Barang yang mungkin anda suka',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: () {
                  List<Widget> result = [];
                  for (int i = -1; i < KategoriBarang.values.length; i++) {
                    result.addAll(
                      [
                        MyChoiceChip(
                          label:
                              i == -1 ? 'Semua' : KategoriBarang.values[i].name,
                          isSelected: i == selectedKategoriIndex,
                          onSelected: (bool value) {
                            setState(() {
                              selectedKategoriIndex = value ? i : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    );
                  }

                  return result;
                }(),
              ),
            ),
            const SizedBox(height: 4),
            Column(
              children: [
                Center(
                  child: FutureBuilder(
                    future: selectedKategoriIndex == -1
                        ? Barang.get()
                        : Barang.get(
                            kategori:
                                KategoriBarang.values[selectedKategoriIndex],
                          ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Gagal memuat produk!'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final List<Barang>? barang = snapshot.data;

                      return Wrap(
                        children: List.generate(
                          barang!.length,
                          (int i) {
                            return MyProdukCard(
                              produk: barang[i],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
