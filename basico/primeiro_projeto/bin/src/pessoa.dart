class Pessoa {
  String nome;
  int idade;
  String sexo;

  // inalterável
  final String sobrenome = 'joão';
  String _nomeLocal = 'nome local';

  // Pessoa({String nome, int idade}) {
  //   this.nome = nome;
  //   this.idade = idade;
  // }

  Pessoa({this.nome, this.idade});

  @override
  String toString() {
    return 'Nome $nome\nIdade: $idade $_nomeLocal';
  }
}
