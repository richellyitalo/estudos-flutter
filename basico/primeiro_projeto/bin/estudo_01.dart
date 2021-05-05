import './src/pessoa.dart';
import 'src/gato.dart';

void main(List<String> arguments) {
  // var pessoa = Pessoa(idade: 33, nome: 'rich');
  // print(pessoa);
  // var pessoa = Pessoa();
  // pessoa.nome = 'Rich';
  // pessoa.idade = 3;
  // print(pessoa);

  var gato = Gato(nome: 'pichano', barulho: 'miau');
  print(gato.nome);
  print(gato.getBarulho());
}
