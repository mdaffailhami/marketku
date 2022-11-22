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
      await collection
          .doc(pengguna!.id)
          .collection('barang')
          .doc(data.id)
          .set(data.toJson());
    } else if (data.runtimeType == Jasa) {
      data = data as Jasa;
      collection
          .doc(pengguna!.id)
          .collection('jasa')
          .doc(data.id)
          .set(data.toJson());
    }
  }

  static Future<List<Barang>> getBarang({KategoriBarang? kategori}) async {
    final pengguna =
        await Pengguna.getById(FirebaseAuth.instance.currentUser!.uid);

    List? docs;
    if (kategori == null) {
      docs = (await collection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('barang')
              .get())
          .docs;
    } else {
      docs = (await collection
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('barang')
              .where('kategori', arrayContains: kategori.name)
              .get())
          .docs;
    }

    List<Barang> result = [];

    for (int i = 0; i < docs.length; i++) {
      result.add(Barang.fromJson(docs[i].data()));
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
