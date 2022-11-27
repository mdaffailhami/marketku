import 'package:flutter/material.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.2,
          ),
        ),
      ),
      child: NavigationBar(
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        height: 66,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
            tooltip: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.storefront_rounded),
            icon: Icon(Icons.storefront),
            label: 'MarketKu',
            tooltip: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
            label: 'Favorit',
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
