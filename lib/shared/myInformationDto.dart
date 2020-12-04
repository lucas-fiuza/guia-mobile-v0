class MyInformationDto {
  String desenvolvedor;
  String versao;
  String tema;
  String objetivo;

  MyInformationDto({this.desenvolvedor, this.versao, this.tema, this.objetivo});

  MyInformationDto.fromJson(Map<String, dynamic> json) {
    desenvolvedor = json['desenvolvedor'];
    versao = json['versao'];
    tema = json['tema'];
    objetivo = json['objetivo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desenvolvedor'] = this.desenvolvedor;
    data['versao'] = this.versao;
    data['tema'] = this.tema;
    data['objetivo'] = this.objetivo;
    return data;
  }
}