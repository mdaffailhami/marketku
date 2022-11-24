import 'package:flutter/material.dart';
import 'package:marketku/models/produk.dart';

class MyDetailProdukPage extends StatefulWidget {
  const MyDetailProdukPage({Key? key, required this.produk}) : super(key: key);

  final Produk produk;

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

  @override
  Widget build(BuildContext context) {
    const blurRadius = 0.2;

    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Aowkwk')),
          ElevatedButton(onPressed: () {}, child: const Text('Aowkwk')),
          ElevatedButton(onPressed: () {}, child: const Text('Aowkwk')),
        ],
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
                    : [const Shadow(blurRadius: blurRadius)],
              ),
              tooltip: 'Kembali',
              color: isShrink && isOnLightMode ? Colors.black : Colors.white,
            ),
            foregroundColor:
                isShrink && isOnLightMode ? Colors.black : Colors.white,
            title: Text(
              isShrink && isOnLightMode ? widget.produk.nama : 'Detail Produk',
              style: TextStyle(
                shadows: isShrink && isOnLightMode
                    ? null
                    : [const Shadow(blurRadius: blurRadius)],
              ),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.white,
            //       shadows: [Shadow(blurRadius: blurRadius)],
            //     ),
            //   ),
            //   SizedBox(width: 5),
            // ],

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(bottom: 16, left: 20),
              title: isShrink
                  ? null
                  : Text(
                      widget.produk.nama,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        shadows: [Shadow(blurRadius: 0.5)],
                      ),
                      maxLines: 2,
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
                  const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/ogw/AOh-ky3NN20jAI3Ftj9lozPTrio3bl99T6W5P7JriaAtLA=s32-c-mo'),
                    ),
                    title: Text('Daffa Ilhami'),
                  ),
                  const Divider(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ActionChip(
                          label: const Text('Fashion'),
                          onPressed: () {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          side: BorderSide.none,
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          label: const Text('Kuliner'),
                          onPressed: () {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          side: BorderSide.none,
                        ),
                        const SizedBox(width: 8),
                        ActionChip(
                          label: const Text('Elektronik'),
                          onPressed: () {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          side: BorderSide.none,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.produk.harga.toString(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const Text(
                      'lorem kjasdbkas sajd baskjdb askdb lasdn lasd lakbdlas blksa bdlas blasjd blasjdb lasj blsaj b'),
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
