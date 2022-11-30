import 'package:flutter/material.dart';
import 'package:marketku/models/pengguna.dart';
import 'package:marketku/models/produk.dart';

import 'detail_produk_page.dart';

class MyProdukCard extends StatelessWidget {
  const MyProdukCard({
    Key? key,
    required this.jenisProduk,
    required this.produk,
    required this.pemilik,
  }) : super(key: key);

  final JenisProduk jenisProduk;
  final Produk produk;
  final Pengguna pemilik;

  final String urlFotoProfilDefault =
      'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=170x170&k=20&c=pVkxcoiVUlD0uOzasLU41qdrAQpT1B3vBfKSJQWuNq4=';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: MyDetailProdukPage(
                jenisProduk: jenisProduk,
                produk: produk,
                pemilik: pemilik,
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
            height: 210,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  foregroundImage: NetworkImage(
                                    pemilik.urlFotoProfil ??
                                        urlFotoProfilDefault,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  pemilik.nama,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                            const Divider(height: 6),
                            Text(
                              produk.harga.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).colorScheme.outline,
                            size: 12,
                          ),
                          Flexible(
                            child: Text(
                              pemilik.lokasi ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.outline,
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
