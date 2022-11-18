import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marketku/models/respon.dart';

import 'pengguna.dart';

class Akun {
  Akun({
    required this.nama,
    required this.alamatEmail,
    required String kataSandi,
  }) : _kataSandi = kataSandi;

  String nama;
  String alamatEmail;
  final String _kataSandi;

  static Future<Respon> add(Akun akun) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: akun.alamatEmail,
        password: akun._kataSandi,
      );

      final pengguna = Pengguna(nama: akun.nama, alamatEmail: akun.alamatEmail);

      FirebaseFirestore.instance
          .collection('pengguna')
          .doc(userCredential.user!.uid)
          .set(pengguna.toJson());

      return Respon(sukses: true, pesan: 'Akun berhasil dibuat!');
    } catch (e) {
      return Respon(sukses: false, pesan: (e as FirebaseAuthException).code);
    }
  }
}
