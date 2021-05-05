import "dart:io";

Map<String, dynamic> cadastro = {};
List<Map<String, dynamic>> cadastros = [];

main() {
  cadastro["nome"] = "rich";
  cadastro["idade"] = 33;
  cadastros.add(cadastro);

  cadastro = {};
  cadastro["nome"] = "rich2";
  cadastro["idade"] = 33;

  cadastros.add(cadastro);

  print(cadastros);
  // Map<String, dynamic> maps = {
  //   "name": "rich",
  //   "age": 30,
  //   "cidade": "Mos",
  //   "estado": "RN"
  // };
  // cadastro["name"] = "Rich";
  // cadastro['idade'] = 73;
  // print(cadastro.keys);
  // print(cadastro.keys.length);
  // cadastro.forEach((key, value) {
  //   print(key);
  // });
}
