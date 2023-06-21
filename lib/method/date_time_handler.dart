List<int> dateTimeParser(String string, {Pattern splitSymbol = '-'}) {
  final split = string.split(splitSymbol);
  final List<int> f = [];
  for (final e in split) {
    f.add(int.tryParse(e) ?? -1);
  }
  print(f);
  return f;
}
