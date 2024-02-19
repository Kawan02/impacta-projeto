class ContatosModel {
  int? id;
  String? nome;
  String? sobrenome;
  String? telephone;
  String? image;
  String? createdAt;
  String? updateAt;
  bool? favorito;
  String? sexo;

  ContatosModel({
    this.id,
    this.nome,
    this.sobrenome,
    this.telephone,
    this.image,
    this.createdAt,
    this.updateAt,
    this.favorito,
    this.sexo,
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
      sexo: json['sexo'],
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
        'sexo': sexo,
      };
}
