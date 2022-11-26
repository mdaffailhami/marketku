import 'package:cloud_firestore/cloud_firestore.dart';

import 'jasa.dart';
import 'pengguna.dart';

class JasaFavorit {
  static final collection =
      FirebaseFirestore.instance.collection('jasa_favorit');

  String id;
  String idPengguna;
  String idJasa;

  JasaFavorit({
    String? id,
    required this.idPengguna,
    required this.idJasa,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  static Future<bool> checkIfJasaIsSaved(Jasa jasa, Pengguna pengguna) async {
    final snapshot = await collection
        .where('id_pengguna', isEqualTo: pengguna.id)
        .where('id_jasa', isEqualTo: jasa.id)
        .get();

    if (snapshot.size == 0) {
      return false;
    } else {
      return true;
    }
  }
}
