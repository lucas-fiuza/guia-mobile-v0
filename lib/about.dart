import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      child: Image.asset('assets/images/eu.png', scale: 3,)
                    )
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Desenvolvedor: Lucas Fiuza R. Pereira"),
                Text("Versão: v0.0.1"),
                Text("Tema: Guia Comercial"),
                Text("Objetivo: Auxiliar o usuário na busca\npor comércios em geral na cidade.",textAlign: TextAlign.center,),
              ],
            )
          ],
        ),
      ),
      
    );
  }
}
