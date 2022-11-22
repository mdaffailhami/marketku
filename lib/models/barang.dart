import 'dart:math';

import 'produk.dart';
import 'rupiah.dart';

enum KategoriBarang { Kuliner, Fashion, Elektronik }

class Barang extends Produk {
  Barang({
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

  factory Barang.fromJson(Map<String, dynamic> data) {
    List<KategoriBarang> kategori = [];

    for (int i = 0; i < data['kategori'].length; i++) {
      kategori.add(KategoriBarang.values.firstWhere((element) =>
          element.toString() == 'KategoriBarang.${data['kategori'][i]}'));
    }

    return Barang(
      id: data['id'],
      urlFoto: data['url_foto'],
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      harga: Rupiah(data['harga']),
      lokasi: data['lokasi'],
      kategori: kategori,
    );
  }

  List<KategoriBarang> kategori;

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
