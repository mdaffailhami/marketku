import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketku/main.dart';
import 'package:marketku/models/barang.dart';
import 'package:marketku/models/barang_favorit.dart';
import 'package:marketku/models/jasa.dart';
import 'package:marketku/models/jasa_favorit.dart';
import 'package:marketku/models/pengguna.dart';
import 'package:marketku/models/produk.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDetailProdukPage extends StatefulWidget {
  const MyDetailProdukPage(
      {Key? key,
      required this.produk,
      required this.pemilik,
      this.currentUserIsPemilik = false})
      : super(key: key);

  final Produk produk;
  final Pengguna pemilik;
  final bool currentUserIsPemilik;

  @override
  State<MyDetailProdukPage> createState() => _MyDetailProdukPageState();
}

class _MyDetailProdukPageState extends State<MyDetailProdukPage> {
  late ScrollController scrollController;

  bool lastStatus = true;
  double imageHeight = 260;

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return scrollController.hasClients &&
        scrollController.offset > (imageHeight - kToolbarHeight * 1.3);
  }

  bool get isOnLightMode => Theme.of(context).brightness == Brightness.light;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Widget buildFavoritButton() {
    final dummyIconButton = IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.bookmark_outline,
        color: Colors.transparent,
      ),
    );

    if (widget.produk.runtimeType == Barang) {
      final barang = widget.produk as Barang;

      final currentUser = MyApp.pengguna;

      return FutureBuilder(
        future: BarangFavorit.checkIfBarangIsSaved(barang, currentUser!),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return dummyIconButton;
          }

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!) {
              return IconButton(
                tooltip: 'Hapus dari favorit',
                onPressed: () async {
                  currentUser.removeBarangFavorit(barang).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Produk berhasil dihapus dari daftar favorit',
                        ),
                      ),
                    );

                    setState(() {});
                  });
                },
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 2)],
                ),
              );
            } else {
              return IconButton(
                tooltip: 'Tambahkan ke favorit',
                onPressed: () async {
                  currentUser.addBarangFavorit(barang).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Produk berhasil ditambahkan ke daftar favorit',
                        ),
                      ),
                    );

                    setState(() {});
                  });
                },
                icon: const Icon(
                  Icons.bookmark_outline,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 2)],
                ),
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    } else {
      final jasa = widget.produk as Jasa;

      final currentUser = MyApp.pengguna;

      return FutureBuilder(
        future: JasaFavorit.checkIfJasaIsSaved(jasa, currentUser!),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return dummyIconButton;
          }

          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!) {
              return IconButton(
                tooltip: 'Hapus dari favorit',
                onPressed: () async {
                  currentUser.removeJasaFavorit(jasa).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Produk berhasil dihapus dari daftar favorit',
                        ),
                      ),
                    );

                    setState(() {});
                  });
                },
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 2)],
                ),
              );
            } else {
              return IconButton(
                tooltip: 'Tambahkan ke favorit',
                onPressed: () async {
                  currentUser.addJasaFavorit(jasa).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Produk berhasil ditambahkan ke daftar favorit',
                        ),
                      ),
                    );

                    setState(() {});
                  });
                },
                icon: const Icon(
                  Icons.bookmark_outline,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 2)],
                ),
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const String urlFotoProfilDefault =
        'https://media.istockphoto.com/id/1223671392/vector/default-profile-picture-avatar-photo-placeholder-vector-illustration.jpg?s=170x170&k=20&c=pVkxcoiVUlD0uOzasLU41qdrAQpT1B3vBfKSJQWuNq4=';

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onPrimary,
        onPressed: () async {
          final initialMessage = Uri.encodeComponent(
            '*PRODUK*\nNama: ${widget.produk.nama}\nHarga: ${widget.produk.harga}\nFoto: ${widget.produk.urlFoto}\n\nPesan: ',
          );

          final url = Uri.parse(
              'https://wa.me/62${widget.pemilik.nomorWhatsApp}?text=$initialMessage');

          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gagal menghubungi penjual!')),
            );
          }
        },
        icon: const Icon(Icons.message_outlined),
        label: const Text('Hubungi Penjual'),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            surfaceTintColor: Theme.of(context).colorScheme.background,
            pinned: true,
            expandedHeight: imageHeight,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                shadows: isShrink && isOnLightMode
                    ? null
                    : [const Shadow(blurRadius: 2)],
              ),
              tooltip: 'Kembali',
              color: isShrink && isOnLightMode ? Colors.black : Colors.white,
            ),
            foregroundColor:
                isShrink && isOnLightMode ? Colors.black : Colors.white,
            title: Text(
              isShrink ? widget.produk.nama : 'Detail Produk',
              style: TextStyle(
                shadows: isShrink && isOnLightMode
                    ? null
                    : [const Shadow(blurRadius: 2)],
              ),
            ),
            actions: [
              Visibility(
                visible: widget.currentUserIsPemilik,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Hapus produk'),
                          content: const Text(
                              'Apakah anda yakin ingin menghapus produk ini?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () async {
                                final pengguna = await Pengguna.getById(
                                    FirebaseAuth.instance.currentUser!.uid);

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

                                pengguna!.removeProduk(widget.produk).then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Produk berhasil dihapus!'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  tooltip: 'Hapus produk',
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 20),
              title: isShrink
                  ? null
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.produk.nama,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              shadows: [Shadow(blurRadius: 2)],
                            ),
                            maxLines: 2,
                          ),
                        ),
                        buildFavoritButton(),
                      ],
                    ),
              background: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black87,
                    builder: (context) => Dialog(
                      child: Image.network(widget.produk.urlFoto),
                    ),
                  );
                },
                child: Hero(
                  tag: widget.produk.id,
                  child: Image.network(
                    widget.produk.urlFoto,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: imageHeight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                          widget.pemilik.urlFotoProfil ?? urlFotoProfilDefault),
                    ),
                    title: Text(widget.pemilik.nama),
                    subtitle: Text(widget.pemilik.lokasi ?? ''),
                  ),
                  const Divider(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: () {
                        if (widget.produk.runtimeType == Barang) {
                          final barang = widget.produk as Barang;

                          return List.generate(barang.kategori.length, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ActionChip(
                                label: Text(barang.kategori[i].name),
                                onPressed: () {},
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                side: BorderSide.none,
                              ),
                            );
                          });
                        } else {
                          final jasa = widget.produk as Jasa;

                          return List.generate(jasa.kategori.length, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ActionChip(
                                label: Text(jasa.kategori[i].name),
                                onPressed: () {},
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                side: BorderSide.none,
                              ),
                            );
                          });
                        }
                      }(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.produk.harga.toString(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Text(widget.produk.deskripsi),
                  const SizedBox(height: 2000),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
