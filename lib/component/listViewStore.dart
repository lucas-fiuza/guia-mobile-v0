import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guia_comercial_mobile/shared/storeDto.dart';

class StoreList extends StatelessWidget {
  final List<Commerce> store;
  StoreList({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: store == null ? 0 : store.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              var dados = Map();
              dados['descricao'] = store[index].descricao;
              dados['endereco'] = store[index].endereco;
              dados['imagem'] = store[index].imagem;
              dados['nome'] = store[index].nome;
              dados['telefone'] = store[index].telefone;
              dados['tipo'] = store[index].tipo;
              dados['id'] = store[index].id;

              Navigator.pushNamed(context, '/TelaLoja', arguments: dados);
            },
            child: new Card(
              child: new Container(
                child: new Center(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text(
                      store[index].nome,
                      style: new TextStyle(
                          fontSize: 20.0, color: Colors.blue),
                    ),
                    new Text(
                      "Tipo: " + store[index].tipo,
                      style: new TextStyle(fontSize: 10.0, color: Colors.lightBlueAccent),
                    ),
                  ],
                )),
                padding: const EdgeInsets.all(15.0),
              ),
            ),
          );
        });
  }
}
