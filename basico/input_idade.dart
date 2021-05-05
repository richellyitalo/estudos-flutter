import "dart:io";

main() {
  
  mostrarIdade(informarIdade());
}

int informarIdade() {
  String ina = stdin.readLineSync() as String;
  int idade = int.parse(ina);
  return idade;
}

void mostrarIdade(int idade) {
  print(idade);
}
