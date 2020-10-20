import 'package:socialfood/app/data/model/pessoa.dart';

class Usuario {
  int id;
  String nome;
  String senha;
  Pessoa pessoa;
  String grupo;

  Usuario(
      {this.id,
      this.nome,
      this.senha, this.grupo,});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    senha = json['senha'];
    grupo = json['grupo'];
    pessoa = Pessoa.fromJson(json['pessoa']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['senha'] = this.senha;
    data['pessoa'] = this.pessoa.toJson();
    return data;
  }
}
