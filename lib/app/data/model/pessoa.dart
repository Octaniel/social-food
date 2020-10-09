class Pessoa{
  int id;
  String nome;
  String apelido;
  String email;
  String pais;
  String telemovel;
  DateTime dataNascimento;
  String fotoUrl;

  Pessoa({this.id, this.nome, this.apelido, this.email, this.pais,
      this.telemovel, this.dataNascimento, this.fotoUrl});

  Pessoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    apelido = json['apelido'];
    email = json['email'];
    pais = json['pais'];
    telemovel = json['telemovel'];
    dataNascimento = DateTime.parse(json['dataNascimento']);
    fotoUrl = json['fotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['apelido'] = this.apelido;
    data['email'] = this.email;
    data['pais'] = this.pais;
    data['telemovel'] = this.telemovel;
    data['dataNascimento'] = this.dataNascimento;
    data['fotoUrl'] = this.fotoUrl;
    return data;
  }

  Map<String, dynamic> toJsonId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pessoa && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}