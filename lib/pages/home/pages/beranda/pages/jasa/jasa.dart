import 'package:flutter/material.dart';
import 'package:marketku/models/jasa.dart';
import 'package:marketku/models/pengguna.dart';
import 'package:marketku/widgets/banner.dart';
import 'package:marketku/widgets/choice_chip.dart';
import 'package:marketku/widgets/produk_card.dart';

class MyJasaPage extends StatefulWidget {
  const MyJasaPage({super.key});

  @override
  State<MyJasaPage> createState() => _MyJasaPageState();
}

class _MyJasaPageState extends State<MyJasaPage> {
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
              imageAsset: 'assets/jasa-page-banner.jpg',
              text: 'Kami menyediakan berbagai jasa yang layak untuk anda!',
            ),
            const SizedBox(height: 12),
            Text(
              'Jasa untuk anda',
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
                  for (int i = -1; i < KategoriJasa.values.length; i++) {
                    result.addAll(
                      [
                        MyChoiceChip(
                          label:
                              i == -1 ? 'Semua' : KategoriJasa.values[i].name,
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
                        ? Jasa.get()
                        : Jasa.get(
                            kategori:
                                KategoriJasa.values[selectedKategoriIndex],
                          ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Gagal memuat produk!'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final List<Jasa>? jasa = snapshot.data;

                      return Wrap(
                        children: List.generate(
                          jasa!.length,
                          (int i) {
                            return FutureBuilder(
                              future: Pengguna.getById(jasa[i].idPengguna),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                      child: Text('Gagal memuat produk!'));
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox.shrink();
                                }

                                final pemilik = snapshot.data!;

                                return MyProdukCard(
                                  produk: jasa[i],
                                  pemilik: pemilik,
                                );
                              },
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
