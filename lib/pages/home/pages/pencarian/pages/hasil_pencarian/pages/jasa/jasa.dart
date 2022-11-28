import 'package:flutter/material.dart';
import 'package:marketku/models/pengguna.dart';
import 'package:marketku/models/jasa.dart';
import 'package:marketku/widgets/choice_chip.dart';
import 'package:marketku/widgets/produk_card.dart';

class MyJasaPage extends StatefulWidget {
  const MyJasaPage({super.key, required this.kataKunci});

  final List<String> kataKunci;

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
                        ? Jasa.get(
                            tampilkanJasaSaya: true,
                            kataKunci: widget.kataKunci,
                          )
                        : Jasa.get(
                            tampilkanJasaSaya: true,
                            kataKunci: widget.kataKunci,
                            kategori:
                                KategoriJasa.values[selectedKategoriIndex],
                          ),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text(
                          'Kata kunci tidak boleh lebih dari 10!',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final List<Jasa>? jasa = snapshot.data;

                      if (jasa!.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text('Produk tidak ditemukan!'),
                        );
                      }

                      return Wrap(
                        children: List.generate(
                          jasa.length,
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
