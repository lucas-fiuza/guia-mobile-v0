class Commerce {
  final int id;
  final String tipo;
  final String nome;
  final String descricao;
  final String endereco;
  final String telefone;
  final String imagem;

  Commerce(
      {this.id,
      this.tipo,
      this.nome,
      this.descricao,
      this.endereco,
      this.telefone,
      this.imagem});

  factory Commerce.fromJson(Map<String, dynamic> json) {
    return new Commerce(
      id: json['id'] as int,
      tipo: json['tipo'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      endereco: json['endereco'] as String,
      telefone: json['telefone'] as String,
      imagem: json['imagem'] as String
    );
  }
}
