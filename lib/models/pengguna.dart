import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketku/models/pengaturan_pengguna.dart';

class Pengguna {
  Pengguna({
    required this.nama,
    required this.alamatEmail,
    this.urlFotoProfil,
    this.deskripsi,
    this.pengaturan,
  });

  String nama;
  String alamatEmail;
  String? urlFotoProfil;
  String? deskripsi;
  PengaturanPengguna? pengaturan;

  static var collection = FirebaseFirestore.instance.collection('pengguna');

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alamat_email': alamatEmail,
      'url_foto_profil': urlFotoProfil,
      'deskripsi': deskripsi,
      'pengaturan': pengaturan,
    };
  }
}
