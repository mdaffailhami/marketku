import 'dart:math';

import 'produk.dart';
import 'rupiah.dart';

enum KategoriJasa { Kebersihan, Penampilan }

class Jasa extends Produk {
  Jasa({
    String? id,
    required String urlFoto,
    required String nama,
    required String deskripsi,
    required Rupiah harga,
    required String lokasi,
    required this.kategori,
  }) : super(
          id: id,
          urlFoto: urlFoto,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
          lokasi: lokasi,
        );

  factory Jasa.fromJson(Map<String, dynamic> data) {
    List<KategoriJasa> kategori = [];

    for (int i = 0; i < data['kategori'].length; i++) {
      kategori.add(KategoriJasa.values.firstWhere((element) =>
          element.toString() == 'KategoriJasa.${data['kategori'][i]}'));
    }

    return Jasa(
      id: data['id'],
      urlFoto: data['url_foto'],
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      harga: Rupiah(data['harga']),
      lokasi: data['lokasi'],
      kategori: kategori,
    );
  }

  List<KategoriJasa> kategori;

  @override
  Map<String, dynamic> toJson() {
    var result = super.toJson();
    result['kategori'] = [];

    for (int i = 0; i < kategori.length; i++) {
      (result['kategori'] as List).add(kategori[i].name);
    }

    return result;
  }
}
