import 'dart:io';

import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketku/main.dart';
import 'package:marketku/models/pengguna.dart';
import 'package:marketku/widgets/text_form_field.dart';

class MyProfilPage extends StatefulWidget {
  const MyProfilPage({super.key});

  @override
  State<MyProfilPage> createState() => _MyProfilPageState();
}

class _MyProfilPageState extends State<MyProfilPage> {
  final formKey = GlobalKey<FormState>();
  final defaultUrlFoto =
      'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=170x170&k=20&c=pVkxcoiVUlD0uOzasLU41qdrAQpT1B3vBfKSJQWuNq4=';

  File? foto;
  String? nama;
  String? lokasi;
  String? nomorWhatsApp;

  void simpanProfil() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    // Show progress indicator
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    final pengguna = MyApp.pengguna;

    String? urlFoto;

    if (foto != null) {
      final fileRef = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      try {
        await fileRef.putFile(foto as File);

        urlFoto = await fileRef.getDownloadURL();
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan profil! (${e.code})')));
        return;
      }
    }

    Pengguna.update(
      Pengguna(
        id: pengguna!.id,
        nama: nama ?? pengguna.nama,
        alamatEmail: pengguna.alamatEmail,
        urlFotoProfil: urlFoto ?? pengguna.urlFotoProfil,
        lokasi: lokasi ?? pengguna.lokasi,
        nomorWhatsApp: nomorWhatsApp ?? pengguna.nomorWhatsApp,
      ),
    ).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profil tersimpan!')));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const MyMaterialApp(),
        ),
        (_) => false,
      );
    });
  }

  void pilihFoto() async {
    final picker = ImagePicker();
    XFile? foto;

    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: const Text('Foto profil'),
          children: [
            PopupMenuItem(
              onTap: () async {
                foto = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 20,
                );

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
                foto = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 20,
                );

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

  @override
  Widget build(BuildContext context) {
    const Size imageSize = Size(150, 150);

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
        title: const Text('Edit Profil'),
        actions: [
          TextButton(onPressed: simpanProfil, child: const Text('Simpan')),
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
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black87,
                      builder: (context) => Dialog(
                        child: Builder(builder: (_) {
                          if (foto != null) {
                            return Image.file(foto!);
                          } else {
                            return Image.network(
                              MyApp.pengguna!.urlFotoProfil ?? defaultUrlFoto,
                            );
                          }
                        }),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: imageSize.width,
                    height: imageSize.height,
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.outline,
                            radius: 71.3,
                            child: foto != null
                                ? CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    backgroundImage: FileImage(foto!),
                                    radius: 70,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    backgroundImage: NetworkImage(
                                      MyApp.pengguna!.urlFotoProfil ??
                                          defaultUrlFoto,
                                    ),
                                    radius: 70,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          right: 3,
                          child: FloatingActionButton.small(
                            onPressed: pilihFoto,
                            shape: const CircleBorder(),
                            elevation: 0,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MyTextFormField(
                onChanged: (String value) => nama = value,
                labelText: 'Nama',
                initialValue: MyApp.pengguna!.nama,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (String? value) =>
                    value!.isEmpty ? 'Nama tidak boleh kosong!' : null,
              ),
              MyTextFormField(
                onChanged: (String value) => lokasi = value,
                labelText: 'Lokasi',
                initialValue: MyApp.pengguna!.lokasi,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              MyTextFormField(
                onChanged: (String value) => nomorWhatsApp = value,
                labelText: 'Nomor WhatsApp',
                initialValue: MyApp.pengguna!.nomorWhatsApp,
                prefix: Text(
                  '+62',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                hintText: '81234567890',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (_) => simpanProfil(),
              ),
            ].mapIndexed((i, widget) {
              return i == 0
                  ? widget
                  : Padding(
                      padding: const EdgeInsets.only(top: 12), child: widget);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
