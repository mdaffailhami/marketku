import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marketku/utils.dart';

import 'produk.dart';
import 'rupiah.dart';

enum KategoriBarang {
  Kuliner,
  Elektronik,
  Fesyen,
  Furnitur,
  Dapur,
  Kebersihan,
  Konstruksi,
}

class Barang extends Produk {
  Barang({
    String? id,
    required String idPengguna,
    required String urlFoto,
    required String nama,
    required String deskripsi,
    required Rupiah harga,
    required this.kategori,
  }) : super(
          id: id,
          idPengguna: idPengguna,
          urlFoto: urlFoto,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
        );

  factory Barang.fromJson(Map<String, dynamic> data) {
    List<KategoriBarang> kategori = [];

    for (int i = 0; i < data['kategori'].length; i++) {
      kategori.add(KategoriBarang.values.firstWhere((element) =>
          element.toString() == 'KategoriBarang.${data['kategori'][i]}'));
    }

    return Barang(
      id: data['id'],
      idPengguna: data['id_pengguna'],
      urlFoto: data['url_foto'],
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      harga: Rupiah(data['harga']),
      kategori: kategori,
    );
  }

  static final collection = FirebaseFirestore.instance.collection('barang');

  List<KategoriBarang> kategori;

  static Future<List<Barang>> get({
    KategoriBarang? kategori,
    List<String>? kataKunci,
    bool tampilkanBarangSaya = false,
  }) async {
    final idPengguna = FirebaseAuth.instance.currentUser!.uid;

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;

    if (kataKunci == null) {
      if (kategori == null) {
        if (tampilkanBarangSaya) {
          docs = (await collection.get()).docs;
        } else {
          docs = (await collection
                  .where('id_pengguna', isNotEqualTo: idPengguna)
                  .get())
              .docs;
        }
      } else {
        if (tampilkanBarangSaya) {
          docs = (await Barang.collection
                  .where('kategori', arrayContains: kategori.name)
                  .get())
              .docs;
        } else {
          docs = (await Barang.collection
                  .where('id_pengguna', isNotEqualTo: idPengguna)
                  .where('kategori', arrayContains: kategori.name)
                  .get())
              .docs;
        }
      }
    } else {
      kataKunci = splitKataKunci(joinKataKunci(kataKunci), uppercase: true);

      if (kategori == null) {
        if (tampilkanBarangSaya) {
          docs = (await collection
                  .where('kata_kunci', arrayContainsAny: kataKunci)
                  .get())
              .docs;
        } else {
          docs = (await collection
                  .where('id_pengguna', isNotEqualTo: idPengguna)
                  .where('kata_kunci', arrayContainsAny: kataKunci)
                  .get())
              .docs;
        }
      } else {
        if (tampilkanBarangSaya) {
          docs = (await Barang.collection
                  .where('kata_kunci', arrayContainsAny: kataKunci)
                  .get())
              .docs
              .where((element) =>
                  (element['kategori'] as List).contains(kategori.name))
              .toList();
        } else {
          docs = (await Barang.collection
                  .where('id_pengguna', isNotEqualTo: idPengguna)
                  .where('kata_kunci', arrayContainsAny: kataKunci)
                  .where('kategori', arrayContains: kategori.name)
                  .get())
              .docs
              .where((element) =>
                  (element['kategori'] as List).contains(kategori.name))
              .toList();
        }
      }
    }

    List<Barang> result = [];

    for (int i = docs.length - 1; i >= 0; i--) {
      result.add(Barang.fromJson(docs[i].data()));
    }

    return result;
  }

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
