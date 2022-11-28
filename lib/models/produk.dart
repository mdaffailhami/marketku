import 'package:marketku/utils.dart';

import 'rupiah.dart';

enum JenisProduk { barang, jasa }

abstract class Produk {
  Produk({
    String? id,
    required this.idPengguna,
    required this.urlFoto,
    required this.nama,
    required this.deskripsi,
    required this.harga,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        kataKunci = splitKataKunci(nama, uppercase: true);

  String id;
  String idPengguna;
  String urlFoto;
  String nama;
  String deskripsi;
  Rupiah harga;
  List<String> kataKunci;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pengguna': idPengguna,
      'url_foto': urlFoto,
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga.nilai,
      'kata_kunci': kataKunci,
    };
  }
}
