import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marketku/pages/home/pages/pencarian/utils.dart';

import 'produk.dart';
import 'rupiah.dart';

enum KategoriJasa { Kebersihan, Penampilan }

class Jasa extends Produk {
  Jasa({
    String? id,
    required String idPengguna,
    required String urlFoto,
    required String nama,
    required String deskripsi,
    required Rupiah harga,
    required String lokasi,
    required this.kategori,
  }) : super(
          id: id,
          idPengguna: idPengguna,
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
      idPengguna: data['id_pengguna'],
      urlFoto: data['url_foto'],
      nama: data['nama'],
      deskripsi: data['deskripsi'],
      harga: Rupiah(data['harga']),
      lokasi: data['lokasi'],
      kategori: kategori,
    );
  }

  static final collection = FirebaseFirestore.instance.collection('jasa');

  List<KategoriJasa> kategori;

  static Future<List<Jasa>> get({
    KategoriJasa? kategori,
    List<String>? kataKunci,
    bool tampilkanJasaSaya = false,
  }) async {
    final idPengguna = FirebaseAuth.instance.currentUser!.uid;

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;

    if (kataKunci == null) {
      if (kategori == null) {
        if (tampilkanJasaSaya) {
          docs = (await collection.get()).docs;
        } else {
          docs = (await collection
                  .where('id_pengguna', isNotEqualTo: idPengguna)
                  .get())
              .docs;
        }
      } else {
        if (tampilkanJasaSaya) {
          docs = (await Jasa.collection
                  .where('kategori', arrayContains: kategori.name)
                  .get())
              .docs;
        } else {
          docs = (await Jasa.collection
                  .where('id_pengguna', isNotEqualTo: idPengguna)
                  .where('kategori', arrayContains: kategori.name)
                  .get())
              .docs;
        }
      }
    } else {
      kataKunci = splitKataKunci(joinKataKunci(kataKunci), uppercase: true);

      if (kategori == null) {
        if (tampilkanJasaSaya) {
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
        if (tampilkanJasaSaya) {
          docs = (await Jasa.collection
                  .where('kata_kunci', arrayContainsAny: kataKunci)
                  .get())
              .docs
              .where((element) =>
                  (element['kategori'] as List).contains(kategori.name))
              .toList();
        } else {
          docs = (await Jasa.collection
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

    List<Jasa> result = [];

    for (int i = docs.length - 1; i >= 0; i--) {
      result.add(Jasa.fromJson(docs[i].data()));
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
