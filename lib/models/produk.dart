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
    required this.lokasi,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  String id;
  String idPengguna;
  String urlFoto;
  String nama;
  String deskripsi;
  Rupiah harga;
  String lokasi;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pengguna': idPengguna,
      'url_foto': urlFoto,
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga.nilai,
      'lokasi': lokasi,
    };
  }
}
