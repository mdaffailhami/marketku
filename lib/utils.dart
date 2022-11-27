List<String> splitKataKunci(String kataKunci, {bool uppercase = false}) {
  return uppercase
      ? kataKunci.split(' ').map((e) => e.toUpperCase()).toList()
      : kataKunci.split(' ');
}

String joinKataKunci(List<String> kataKunci) {
  return kataKunci.join(' ');
}
