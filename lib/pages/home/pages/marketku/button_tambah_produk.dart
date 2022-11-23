import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'pages/tambah_produk/tambah_produk.dart';

class ButtonTambahProduk extends StatefulWidget {
  const ButtonTambahProduk({Key? key}) : super(key: key);

  @override
  State<ButtonTambahProduk> createState() => _ButtonTambahProdukState();
}

class _ButtonTambahProdukState extends State<ButtonTambahProduk> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: Text('Tambah produk'),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           child: Text('Batal'),
        //         ),
        //         TextButton(onPressed: () {}, child: Text('Tambah')),
        //       ],
        //       content: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Stack(
        //             children: [
        //               Image.network(
        //                 'https://cf.shopee.ph/file/5596e9c43528a2fb87f3b1c45c2effb3',
        //                 width: 100,
        //                 height: 100,
        //               ),
        //               Positioned(
        //                 bottom: 0,
        //                 child: Container(
        //                   width: 100,
        //                   padding: EdgeInsets.symmetric(vertical: 1),
        //                   color: Colors.black45,
        //                   child: Icon(
        //                     Icons.camera_alt,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //           SizedBox(height: 10),
        //           MyTextFormField(
        //             onChanged: (String value) {},
        //             label: 'Nama Produk',
        //           ),
        //           MyTextFormField(
        //             onChanged: (String value) {},
        //             label: 'Harga',
        //           ),
        //           MyTextFormField(
        //             onChanged: (String value) {},
        //             label: 'Lokasi',
        //           ),
        //           MyDropdownButtonFormField(
        //             onChanged: (String? value) {},
        //             label: 'Jenis Produk',
        //             items: ['Barang', 'Jasa'],
        //           ),
        //           MyDropdownButtonFormField(
        //             onChanged: (String? value) {},
        //             label: 'Kategori',
        //             items: ['Barang', 'Jasa'],
        //           ),
        //         ].mapIndexed((i, widget) {
        //           return i == 0
        //               ? widget
        //               : Padding(
        //                   padding: EdgeInsets.only(top: 10), child: widget);
        //         }).toList(),
        //       ),
        //     );
        //   },
        // );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyTambahProdukPage(),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}

class MyDropdownButtonFormField extends StatelessWidget {
  const MyDropdownButtonFormField({
    Key? key,
    required this.onChanged,
    required this.label,
    required this.items,
  }) : super(key: key);

  final void Function(String? value) onChanged;
  final String label;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: DropdownButtonFormField<String>(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.outline,
              ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            onTap: () {},
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  final void Function(String value) onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.outline,
              ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
