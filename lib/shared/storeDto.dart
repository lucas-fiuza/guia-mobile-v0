class Commerce {
  String id;
  String tipo;
  String nome;
  String descricao;
  String endereco;
  String telefone;
  String imagem;

  Commerce(
      {this.id,
      this.tipo,
      this.nome,
      this.descricao,
      this.endereco,
      this.telefone,
      this.imagem});

  Commerce.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    nome = json['nome'];
    descricao = json['descricao'];
    endereco = json['endereco'];
    telefone = json['telefone'];
    imagem = json['imagem'];
  }

  Commerce.fromMap(Map<String, dynamic> map, String id) {
    this.id =  id ?? '';
    this.tipo = map['tipo'];
    this.nome = map['nome'];
    this.descricao = map['descricao'];
    this.endereco = map['endereco'];
    this.telefone = map['telefone'];
    this.imagem = map['imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '';
    data['tipo'] = this.tipo;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['endereco'] = this.endereco;
    data['telefone'] = this.telefone;
    data['imagem'] = this.imagem;
    return data;
  }
}
