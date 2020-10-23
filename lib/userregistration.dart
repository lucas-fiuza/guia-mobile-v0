import 'package:flutter/material.dart';

class TelaCadastroUsuario extends StatefulWidget {
  @override
  _TelaCadastroUsuarioState createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  var formUserKey = GlobalKey<FormState>();

  var txtSenha = TextEditingController();
  var txtUsuario = TextEditingController();
  var txtEmail = TextEditingController();
  var txtApelido = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: formUserKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: txtUsuario,
                      decoration: InputDecoration(labelText: "Usuário"),
                      validator: (value) {
                        return (value.toString() == "")
                            ? "Informe o nome."
                            : null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: txtApelido,
                      decoration: InputDecoration(labelText: "Apelido"),
                      validator: (value) {
                        return (value.toString() == "")
                            ? "Informe o Apelido."
                            : null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: txtEmail,
                      decoration: InputDecoration(labelText: "E-mail"),
                      validator: (value) {
                        return (value.toString() == "")
                            ? "Informe o e-mail."
                            : null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: TextFormField(
                      controller: txtSenha,
                      decoration: InputDecoration(labelText: "Senha"),
                      validator: (value) {
                        return (value.toString() == "")
                            ? "Informe a senha."
                            : null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 40, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                            color: Colors.red[800],
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red[600])),
                            child: Text(
                              "Cancelar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/TelaLogin'));
                            }),
                        RaisedButton(
                            color: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue[600])),
                            child: Text(
                              "Cadastrar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              if (formUserKey.currentState.validate()) {
                                setState(() {
                                  caixaDialogo(txtApelido.text + ", bem vindo!",
                                      "Seu cadastro foi efetuado com sucesso!");
                                });
                              }
                            })
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
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
                    Navigator.popUntil(
                        context, ModalRoute.withName('/TelaLogin'));
                  },
                  child: Text('fechar'))
            ],
          );
        });
  }
}
