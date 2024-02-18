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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['sobrenome'] = sobrenome;
    data['telephone'] = telephone;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updateAt'] = updateAt;
    data['favorito'] = favorito;
    data['sexo'] = sexo;
    return data;
  }
}
