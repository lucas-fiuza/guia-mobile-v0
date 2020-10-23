import 'package:flutter/material.dart';

class TelaLoja extends StatefulWidget {
  @override
  _TelaLoja createState() => _TelaLoja();
}

class _TelaLoja extends State<TelaLoja> {
  @override
  Widget build(BuildContext context) {
    Map dadosLoja = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(dadosLoja['tipo'].toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.width * 1,
                    child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              dadosLoja['imagem'].toString(),
                              scale: 2,
                            ))),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(dadosLoja['nome'].toString(), style: TextStyle(fontSize: 30,),textAlign: TextAlign.center,),
                  Text("Contato:" + dadosLoja['telefone'], style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  Text("Endereço: " + dadosLoja['endereco'], style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                  InkWell(
                    onTap: () {
                      caixaDescricao(dadosLoja['descricao'].toString());
                    },
                    child: Text("Saiba mais.",
                        style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 20),textAlign: TextAlign.center,),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  caixaDescricao(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Descrição", style: TextStyle(fontSize: 12)),
            content: Text(msg, style: TextStyle(fontSize: 16)),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('fechar'))
            ],
          );
        });
  }
}
