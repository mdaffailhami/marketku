import 'package:cloud_firestore/cloud_firestore.dart';

import 'barang.dart';
import 'pengguna.dart';

class BarangFavorit {
  static final collection =
      FirebaseFirestore.instance.collection('barang_favorit');

  String id;
  String idPengguna;
  String idBarang;

  BarangFavorit({
    String? id,
    required this.idPengguna,
    required this.idBarang,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  static Future<bool> checkIfBarangIsSaved(
      Barang barang, Pengguna pengguna) async {
    final snapshot = await collection
        .where('id_pengguna', isEqualTo: pengguna.id)
        .where('id_barang', isEqualTo: barang.id)
        .get();

    if (snapshot.size == 0) {
      return false;
    } else {
      return true;
    }
  }
}
