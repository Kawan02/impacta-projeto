class ContatosModel {
  int? id;
  String? nome;
  String? sobrenome;
  String? telephone;
  String? image;
  String? createdAt;
  String? updateAt;
  bool? favorito;
  String? dtaNascimento;
  String? nota;
  String? amigo;

  ContatosModel({
    this.id,
    this.nome,
    this.sobrenome,
    this.telephone,
    this.image,
    this.createdAt,
    this.updateAt,
    this.favorito,
    this.dtaNascimento,
    this.nota,
    this.amigo,
  });

  factory ContatosModel.fromJson(Map<String, dynamic> json) {
    return ContatosModel(
      id: json['id'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      telephone: json['telephone'],
      image: json['image'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
      favorito: json['favorito'],
      dtaNascimento: json['dtaNascimento'],
      nota: json['nota'],
      amigo: json['amigo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'sobrenome': sobrenome,
        'telephone': telephone,
        'image': image,
        'createdAt': createdAt,
        'updateAt': updateAt,
        'favorito': favorito,
        'dtaNascimento': dtaNascimento,
        'nota': nota,
        'amigo': amigo,
      };
}
