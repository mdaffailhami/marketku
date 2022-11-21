import 'package:flutter/material.dart';
import 'package:marketku/widgets/choice_chip.dart';

class MyDaftarKategori extends StatefulWidget {
  const MyDaftarKategori({super.key});

  @override
  State<MyDaftarKategori> createState() => _MyDaftarKategoriState();
}

class _MyDaftarKategoriState extends State<MyDaftarKategori> {
  final List<String> daftarKategori = [
    'Semua',
    'Kuliner',
    'Fashion',
    'Elektronik'
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: () {
          List<Widget> result = [];
          for (int i = 0; i < daftarKategori.length; i++) {
            result.addAll(
              [
                MyChoiceChip(
                  label: daftarKategori[i],
                  isSelected: i == selectedIndex,
                  onSelected: (bool value) {
                    setState(() {
                      selectedIndex = value ? i : 0;
                    });
                  },
                ),
                SizedBox(width: 8),
              ],
            );
          }

          return result;
        }(),
      ),
    );
  }
}

// class MyOptions extends StatefulWidget {
//   const MyOptions({super.key});

//   @override
//   State<MyOptions> createState() => _MyOptionsState();
// }

// class _MyOptionsState extends State<MyOptions> {
//   int? _value = 0;

//   List<String> chips = ['Semua', 'Kuliner', 'Fashion', 'Elektronik'];

//   @override
//   Widget build(BuildContext context) {
//     return Row(children: () {
//       List<Widget> result = [];
//       for (int i = 0; i < chips.length; i++) {
//         result.addAll(
//           [
//             ,
//             SizedBox(width: 8),
//           ],
//         );
//       }

//       return result;
//     }());
//   }
// }
