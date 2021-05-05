import "dart:io";

const String OPT_SAIR = '0';
const String OPT_ADICIONAR = '1';
const String OPT_IMPRIMIR = '2';
const String OPT_REMOVER = '3';

List<String> produtos = [];

main() {
  String opt = '';

  do {
    menu();
    opt = stdin.readLineSync() as String;

    switch (opt) {
      case OPT_ADICIONAR:
        print("Informe o nome do produto:");
        var nomeProduto = stdin.readLineSync() as String;
        produtos.add(nomeProduto);
        break;
      case OPT_REMOVER:
        remover();
        break;
      case OPT_IMPRIMIR:
        print(produtos);
        print("=========pressione ENTER============");
        stdin.readLineSync();
        break;
    }
  } while (opt != OPT_SAIR);
}

menu() {
  print("Escolha uma ação:");
  print(OPT_ADICIONAR + " - adicionar");
  print(OPT_REMOVER + " - remover");
  print(OPT_IMPRIMIR + " - imprimir");
  print(OPT_SAIR + " - sair");
}

cls() {
  print("\x1B[2J\x1B[0;0H");
}

remover() {
  print("Selecione o produto que deseja remover:");
  for (int i = 0; i < produtos.length; i++) {
    print("${i + 1} - ${produtos[i]}");
  }
  int produtoRemover = int.parse(stdin.readLineSync() as String);
  String nomeProduto = produtos[produtoRemover - 1];
  produtos.removeAt(produtoRemover - 1);

  print(nomeProduto + " removido.");
}
