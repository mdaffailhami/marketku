import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marketku/models/pengaturan_pengguna.dart';

import 'barang.dart';
import 'jasa.dart';
import 'produk.dart';
import 'respon.dart';

class Pengguna {
  Pengguna({
    required this.id,
    required this.nama,
    required this.alamatEmail,
    this.urlFotoProfil,
    this.deskripsi,
    this.pengaturan,
  });

  factory Pengguna.fromJson(Map<String, dynamic> data) {
    return Pengguna(
      id: data['id'],
      nama: data['nama'],
      alamatEmail: data['alamat_email'],
      urlFotoProfil: data['url_foto_profil'],
      deskripsi: data['deskripsi'],
      pengaturan: data['pengaturan'],
    );
  }

  final String id;
  String nama;
  String alamatEmail;
  String? urlFotoProfil;
  String? deskripsi;
  PengaturanPengguna? pengaturan;

  static var collection = FirebaseFirestore.instance.collection('pengguna');

  static Future<Pengguna?> getById(String id) async {
    final pengguna = (await collection.doc(id).get()).data();

    if (pengguna == null) return null;

    return Pengguna.fromJson(pengguna);
  }

  Future<void> addProduk(Produk data) async {
    final pengguna =
        await Pengguna.getById(FirebaseAuth.instance.currentUser!.uid);

    if (data.runtimeType == Barang) {
      data = data as Barang;
      await Barang.collection.doc(data.id).set(data.toJson());
    } else if (data.runtimeType == Jasa) {
      data = data as Jasa;
      await Jasa.collection.doc(data.id).set(data.toJson());
    }
  }

  static Future<List<Barang>> getBarang({KategoriBarang? kategori}) async {
    List? docs;
    if (kategori == null) {
      print('SEMUA');
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'alamat_email': alamatEmail,
      'url_foto_profil': urlFotoProfil,
      'deskripsi': deskripsi,
      'pengaturan': pengaturan,
    };
  }
}
