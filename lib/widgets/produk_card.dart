import 'package:flutter/material.dart';
import 'package:marketku/models/pengguna.dart';
import 'package:marketku/models/produk.dart';

import 'detail_produk_page.dart';

class MyProdukCard extends StatelessWidget {
  const MyProdukCard({
    Key? key,
    required this.produk,
    required this.pemilik,
    this.currentUserIsPemilik = false,
  }) : super(key: key);

  final Produk produk;
  final Pengguna pemilik;
  final bool currentUserIsPemilik;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: MyDetailProdukPage(
                produk: produk,
                pemilik: pemilik,
                currentUserIsPemilik: currentUserIsPemilik,
              ),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Hero(
        tag: produk.id,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: 0.2,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          surfaceTintColor: const Color(0xFFFFFFFF),
          elevation: 0,
          child: SizedBox(
            width: 150,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Image.network(
                        produk.urlFoto,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 6,
                        left: 6,
                        right: 6,
                        child: Text(
                          produk.nama,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            height: 1.15,
                            shadows: [Shadow(blurRadius: 2)],
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produk.harga.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 17,
                          ),
                          Flexible(
                            child: Text(
                              pemilik.lokasi ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
