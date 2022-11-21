import 'package:flutter/material.dart';
import 'package:marketku/models/barang.dart';
import 'package:marketku/models/produk.dart';
import 'package:marketku/models/rupiah.dart';
import 'package:marketku/widgets/produk_card.dart';

class MyDaftarBarang extends StatelessWidget {
  const MyDaftarBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Wrap(
            children: List.generate(
              9,
              (index) {
                return MyProdukCard(
                  produk: Barang(
                    urlFoto:
                        'https://cf.shopee.ph/file/5596e9c43528a2fb87f3b1c45c2effb3',
                    nama: 'Sepatu Wadidaw',
                    deskripsi: "Mana saia tau, saia kan ikan..",
                    harga: Rupiah(80000),
                    lokasi: 'Kayu Tangi 1',
                    kategori: [
                      KategoriBarang.Fashion,
                      KategoriBarang.Elektronik,
                      KategoriBarang.Kuliner,
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
