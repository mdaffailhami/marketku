import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketku/main.dart';
import 'package:marketku/models/barang.dart';
import 'package:marketku/models/jasa.dart';
import 'package:marketku/models/pengguna.dart';
import 'package:marketku/models/produk.dart';
import 'package:marketku/models/rupiah.dart';
import 'package:marketku/widgets/choice_chip.dart';
import 'package:marketku/widgets/text_form_field.dart';

class MyTambahProdukPage extends StatefulWidget {
  const MyTambahProdukPage({Key? key}) : super(key: key);

  @override
  State<MyTambahProdukPage> createState() => _MyTambahProdukPageState();
}

class _MyTambahProdukPageState extends State<MyTambahProdukPage> {
  final formKey = GlobalKey<FormState>();
  final String defaultUrlFoto =
      'https://firebasestorage.googleapis.com/v0/b/marketku-28c01.appspot.com/o/marketku.png?alt=media&token=da682d5b-752c-4472-91bd-1feb9fd61187';

  File? foto;
  String nama = '';
  String deskripsi = '';
  Rupiah harga = Rupiah(0);
  JenisProduk jenisProduk = JenisProduk.barang;
  List<KategoriBarang> kategoriBarang = [];
  List<KategoriJasa> kategoriJasa = [];

  bool isKategoriLebihDari3 = false;
  bool isLoading = false;

  void tambahProduk() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    // Show progress indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    final pengguna = MyApp.pengguna;

    String urlFoto = defaultUrlFoto;

    if (foto != null) {
      final fileRef = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      try {
        await fileRef.putFile(foto as File);

        urlFoto = await fileRef.getDownloadURL();
      } on FirebaseException catch (e) {
        showSnackBar('Gagal menambahkan produk! (${e.code})');
        return;
      }
    }

    if (jenisProduk == JenisProduk.barang) {
      pengguna!.addProduk(
        Barang(
          idPengguna: pengguna.id,
          urlFoto: urlFoto,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
          kategori: kategoriBarang,
        ),
      );
    } else if (jenisProduk == JenisProduk.jasa) {
      pengguna!.addProduk(
        Jasa(
          idPengguna: pengguna.id,
          urlFoto: urlFoto,
          nama: nama,
          deskripsi: deskripsi,
          harga: harga,
          kategori: kategoriJasa,
        ),
      );
    }

    showSnackBar('Produk berhasil ditambahkan!');
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void pilihFoto() async {
    final picker = ImagePicker();
    XFile? foto;

    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text('Foto produk'),
          children: [
            PopupMenuItem(
              onTap: () async {
                foto = await picker.pickImage(source: ImageSource.camera);
                setState(() => this.foto = File(foto!.path));
              },
              child: const ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.camera_alt_outlined),
                title: Text('Tangkap dengan kamera'),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                foto = await picker.pickImage(source: ImageSource.gallery);
                setState(() => this.foto = File(foto!.path));
              },
              child: const ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.photo_outlined),
                title: Text('Pilih dari galeri'),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    const Size imageSize = Size(140, 140);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
          tooltip: 'Kembali',
        ),
        title: const Text('Tambah Produk'),
        actions: [
          TextButton(onPressed: tambahProduk, child: const Text('Tambah')),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  onTap: pilihFoto,
                  child: Stack(
                    children: [
                      foto != null
                          ? Image.file(
                              foto as File,
                              width: imageSize.width,
                              height: imageSize.height,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              defaultUrlFoto,
                              width: imageSize.width,
                              height: imageSize.height,
                            ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: imageSize.width,
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          color: Colors.black45,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                onChanged: (String value) => nama = value,
                labelText: 'Nama Produk',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (String? value) =>
                    value!.isEmpty ? 'Nama Produk tidak boleh kosong!' : null,
              ),
              MyTextFormField(
                onChanged: (String value) => deskripsi = value,
                labelText: 'Deksripsi',
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 3,
                verticalPadding: 12,
              ),
              MyTextFormField(
                onChanged: (String value) => harga.nilai = num.parse(value),
                labelText: 'Harga',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              Text('Jenis', style: Theme.of(context).textTheme.titleLarge),
              Row(
                children: [
                  MyChoiceChip(
                    label: 'Barang',
                    isSelected: jenisProduk == JenisProduk.barang,
                    onSelected: (bool value) {
                      setState(() {
                        kategoriBarang = [];
                        jenisProduk = JenisProduk.barang;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  MyChoiceChip(
                    label: 'Jasa',
                    isSelected: jenisProduk == JenisProduk.jasa,
                    onSelected: (bool value) {
                      setState(() {
                        kategoriJasa = [];
                        jenisProduk = JenisProduk.jasa;
                      });
                    },
                  ),
                ],
              ),
              Text(
                'Kategori',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Visibility(
                visible: isKategoriLebihDari3,
                child: const Text(
                  'Kategori tidak boleh lebih dari 3!',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              () {
                List<Widget> children = [];

                if (jenisProduk == JenisProduk.barang) {
                  const List<KategoriBarang> kategori = KategoriBarang.values;
                  for (int i = 0; i < kategori.length; i++) {
                    children.addAll([
                      MyChoiceChip(
                        label: kategori[i].name,
                        isSelected: kategoriBarang.contains(kategori[i]),
                        onSelected: (bool value) {
                          if (value) {
                            if (kategoriBarang.length < 3) {
                              setState(() {
                                isKategoriLebihDari3 = false;
                                kategoriBarang.add(kategori[i]);
                              });
                            } else {
                              setState(() => isKategoriLebihDari3 = true);
                            }
                          } else {
                            setState(() => kategoriBarang.remove(kategori[i]));
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                    ]);
                  }
                } else if (jenisProduk == JenisProduk.jasa) {
                  const List<KategoriJasa> kategori = KategoriJasa.values;
                  for (int i = 0; i < kategori.length; i++) {
                    children.addAll([
                      MyChoiceChip(
                        label: kategori[i].name,
                        isSelected: kategoriJasa.contains(kategori[i]),
                        onSelected: (bool value) {
                          if (value) {
                            if (kategoriJasa.length < 3) {
                              setState(() {
                                isKategoriLebihDari3 = false;
                                kategoriJasa.add(kategori[i]);
                              });
                            } else {
                              setState(() => isKategoriLebihDari3 = true);
                            }
                          } else {
                            setState(() => kategoriJasa.remove(kategori[i]));
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                    ]);
                  }
                }

                return Wrap(
                  children: children,
                );
              }(),
            ].mapIndexed((i, widget) {
              return i == 0
                  ? widget
                  : Padding(
                      padding: const EdgeInsets.only(top: 10), child: widget);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
