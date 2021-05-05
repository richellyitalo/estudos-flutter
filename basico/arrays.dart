main() {
  // var nomes = [];
  List<String> nomes = [];
  for (int i = 0; i < 5; i++) {
    var nome = i.toString() + "_um_nome";
    nomes.add(nome);
  }

  print(nomes);
}
