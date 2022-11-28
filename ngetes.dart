enum Ngetes { lol, uwu }

void main() {
  print(Ngetes.values.where((element) => element.name == 'uwu').toList()[0]);
}
