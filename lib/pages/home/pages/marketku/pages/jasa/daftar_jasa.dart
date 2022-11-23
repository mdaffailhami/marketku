import 'package:flutter/material.dart';
import 'package:marketku/models/jasa.dart';
import 'package:marketku/models/rupiah.dart';
import 'package:marketku/widgets/produk_card.dart';

class MyDaftarJasa extends StatelessWidget {
  const MyDaftarJasa({Key? key}) : super(key: key);

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
                  produk: Jasa(
                    urlFoto:
                        'https://st2.depositphotos.com/1832477/12084/i/600/depositphotos_120841578-stock-photo-vintage-barber-shop-logos-labels.jpg',
                    nama: 'Potong Rambut Mengkeren',
                    deskripsi: "Bapak kau solo lord pake estes, zehahaha!",
                    harga: Rupiah(15000),
                    lokasi: 'Cendana',
                    kategori: [
                      KategoriJasa.Penampilan,
                      KategoriJasa.Penampilan,
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
