import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaSugestao extends StatefulWidget {
  @override
  _TelaSugestaoState createState() => _TelaSugestaoState();
}

class _TelaSugestaoState extends State<TelaSugestao> {
  var db = FirebaseFirestore.instance;

  var txtSugestao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("Sugestão"),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(5)),
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: txtSugestao,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 10,
                      decoration: InputDecoration.collapsed(
                          hintText: "Descreva sua sugestão"),
                    ),
                  )),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton.icon(
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue[600])),
                    label: Text(
                      "Enviar",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      db.collection("suggestions").add({
                        "userid": id,
                        "datasuggestion": DateTime.now().toString(),
                        "suggestion": txtSugestao.text.toString()
                      });
                      caixaDialogo("Obrigado!",
                          "Iremos analisar sua sugestão com carinho!");
                    }),
              ],
            ),
          ),
        ));
  }

  //
  // CAIXA DE DIÁLOGO
  //
  caixaDialogo(title, msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title, style: TextStyle(fontSize: 12)),
            content: Text(msg, style: TextStyle(fontSize: 16)),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('fechar'))
            ],
          );
        });
  }
}
