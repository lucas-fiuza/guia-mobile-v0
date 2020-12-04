import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'shared/myInformationDto.dart';

class TelaSobre extends StatefulWidget {
  @override
  _TelaSobreState createState() => _TelaSobreState();
}

class _TelaSobreState extends State<TelaSobre> {
  var informacoes = MyInformationDto();
  bool exibir = false;

  Future<int> retornaMeusDados() async {
    try {
      String url = "https://api.mocki.io/v1/1a0bdb6f/MinhaInformacoes";

      var resp = await get(url);

      if (resp.statusCode == 200) {
        setState(() {
          informacoes =
              MyInformationDto.fromJson(json.decode(resp.body.toString()));
          exibir = true;
        });
      }

      return resp.statusCode;
    } catch (e) {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    retornaMeusDados();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width * 1,
                  child: Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.asset(
                            'assets/images/eu.png',
                            scale: 3,
                          ))),
                ),
              ],
            ),
            Visibility(
              visible: exibir,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Desenvolvedor: ${informacoes.desenvolvedor}"),
                  Text("Versão: ${informacoes.versao}"),
                  Text("Tema: ${informacoes.tema}"),
                  Text(
                    "Objetivo: ${informacoes.objetivo}",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
