import 'package:intl/intl.dart';

class Rupiah {
  Rupiah(this.nilai);

  num nilai;

  @override
  String toString() {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp').format(nilai);
  }
}
