import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'barang.dart';
import 'barang_favorit.dart';
import 'jasa.dart';
import 'jasa_favorit.dart';
import 'produk.dart';

class Pengguna {
  Pengguna({
    required this.id,
    required this.nama,
    required this.alamatEmail,
    this.urlFotoProfil,
    this.lokasi,
    this.nomorWhatsApp,
  });

  factory Pengguna.fromJson(Map<String, dynamic> data) {
    return Pengguna(
        id: data['id'],
        nama: data['nama'],
        alamatEmail: data['alamat_email'],
        urlFotoProfil: data['url_foto_profil'],
        lokasi: data['lokasi'],
        nomorWhatsApp: data['nomor_whatsapp']);
  }

  final String id;
  String nama;
  String alamatEmail;
  String? urlFotoProfil;
  String? lokasi;
  String? nomorWhatsApp;

  static var collection = FirebaseFirestore.instance.collection('pengguna');

  static Future<Pengguna?> getById(String id) async {
    final pengguna = (await collection.doc(id).get()).data();

    if (pengguna == null) return null;

    return Pengguna.fromJson(pengguna);
  }

  static Future<void> update(Pengguna pengguna) async {
    await collection.doc(pengguna.id).set(pengguna.toJson());
  }

  Future<void> addProduk(Produk data) async {
    if (data.runtimeType == Barang) {
      data = data as Barang;
      await Barang.collection.doc(data.id).set(data.toJson());
    } else if (data.runtimeType == Jasa) {
      data = data as Jasa;
      await Jasa.collection.doc(data.id).set(data.toJson());
    }
  }

  Future<void> removeProduk(Produk produk) async {
    if (produk.runtimeType == Barang) {
      final barang = produk as Barang;
      await Barang.collection.doc(barang.id).delete();
    } else {
      final jasa = produk as Jasa;
      await Jasa.collection.doc(jasa.id).delete();
    }
  }

  static Future<List<Barang>> getBarang({KategoriBarang? kategori}) async {
    List? docs;
    if (kategori == null) {
      docs = (await Barang.collection
              .where(
                'id_pengguna',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .get())
          .docs;
    } else {
      docs = (await Barang.collection
              .where(
                'id_pengguna',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .where('kategori', arrayContains: kategori.name)
              .get())
          .docs;
    }

    List<Barang> result = [];

    for (int i = docs.length - 1; i >= 0; i--) {
      result.add(Barang.fromJson(docs[i].data()));
    }

    return result;
  }

  static Future<List<Jasa>> getJasa({KategoriJasa? kategori}) async {
    List? docs;
    if (kategori == null) {
      docs = (await Jasa.collection
              .where(
                'id_pengguna',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .get())
          .docs;
    } else {
      docs = (await Jasa.collection
              .where(
                'id_pengguna',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .where('kategori', arrayContains: kategori.name)
              .get())
          .docs;
    }

    List<Jasa> result = [];

    for (int i = docs.length - 1; i >= 0; i--) {
      result.add(Jasa.fromJson(docs[i].data()));
    }

    return result;
  }

  Future<void> addBarangFavorit(Barang barang) async {
    final barangFavorit = BarangFavorit(idPengguna: id, idBarang: barang.id);

    await BarangFavorit.collection.doc(barangFavorit.id).set({
      'id': barangFavorit.id,
      'id_pengguna': barangFavorit.idPengguna,
      'id_barang': barangFavorit.idBarang,
    });
  }

  Future<void> addJasaFavorit(Jasa jasa) async {
    final jasaFavorit = JasaFavorit(idPengguna: id, idJasa: jasa.id);

    await JasaFavorit.collection.doc(jasaFavorit.id).set({
      'id': jasaFavorit.id,
      'id_pengguna': jasaFavorit.idPengguna,
      'id_jasa': jasaFavorit.idJasa,
    });
  }

  Future<void> removeBarangFavorit(Barang barang) async {
    final docs = (await BarangFavorit.collection
            .where('id_pengguna', isEqualTo: id)
            .where('id_barang', isEqualTo: barang.id)
            .get())
        .docs;

    for (var doc in docs) {
      doc.reference.delete();
    }
  }

  Future<void> removeJasaFavorit(Jasa jasa) async {
    final docs = (await JasaFavorit.collection
            .where('id_pengguna', isEqualTo: id)
            .where('id_jasa', isEqualTo: jasa.id)
            .get())
        .docs;

    for (var doc in docs) {
      doc.reference.delete();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'alamat_email': alamatEmail,
      'url_foto_profil': urlFotoProfil,
      'lokasi': lokasi,
      'nomor_whatsapp': nomorWhatsApp,
    };
  }
}
