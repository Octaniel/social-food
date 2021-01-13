class UsuarioResumo {
  int quntidade;
  String mes;

  UsuarioResumo({this.quntidade, this.mes});

  UsuarioResumo.fromJson(Map<String, dynamic> json) {
    quntidade = json['quntidade'];
    mes = json['mes'];
  }

  @override
  String toString() {
    return '{quntidade: $quntidade}';
  }
}
