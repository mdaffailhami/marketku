import 'package:flutter/material.dart';
import 'package:marketku/models/produk.dart';

import 'detail_produk_page.dart';

class MyProdukCard extends StatelessWidget {
  const MyProdukCard({
    Key? key,
    required this.produk,
  }) : super(key: key);

  final Produk produk;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: MyDetailProdukPage(produk: produk),
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
                              produk.lokasi,
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

// class MyCardProduk extends StatelessWidget {
//   const MyCardProduk({
//     Key? key,
//     required this.produk,
//   }) : super(key: key);

//   final Produk produk;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(
//           width: 0.2,
//           color: Theme.of(context).colorScheme.outline,
//         ),
//       ),
//       surfaceTintColor: Color(0xFFFFFFFF),
//       elevation: 0,
//       child: SizedBox(
//         width: 150,
//         height: 200,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   Image.network(
//                     produk.urlGambar,
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                   ),
//                   Positioned(
//                     bottom: 6,
//                     left: 6,
//                     right: 6,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Expanded(
//                           flex: 7,
//                           child: SelectableText(
//                             produk.nama,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               height: 1.15,
//                               shadows: [Shadow(blurRadius: 2)],
//                             ),
//                           ),
//                         ),
//                         Spacer(flex: 1),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Icon(
//                               Icons.star,
//                               color: Colors.yellow,
//                               size: 14,
//                               shadows: [Shadow(blurRadius: 0.5)],
//                             ),
//                             Text(
//                               produk.penilaian.toString(),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                                 shadows: [Shadow(blurRadius: 0.5)],
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(4),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     NumberFormat.currency(locale: 'id', symbol: 'Rp')
//                         .format(produk.harga),
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 3),
//                   Text(
//                     '${produk.jumlahTerjual} Terjual',
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on_outlined,
//                         color: Theme.of(context).colorScheme.primary,
//                         size: 17,
//                       ),
//                       Flexible(
//                         child: Text(
//                           produk.lokasi,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 10,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
