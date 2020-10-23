import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  //Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  //Armazer valores do peso e altura
  var txtSenha = TextEditingController();
  var txtUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(40),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.menu_book,
                        size: 120, color: Theme.of(context).primaryColor),
                    campoTexto(
                        "Usuário", txtUsuario, false, "Digite seu usuário"),
                    campoTexto("Senha", txtSenha, true, "Digite sua senha"),
                    botao("Entrar"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/TelaCadastroUsuario");
              },
              child: Text("Não sou cadastrado.",
                  style: TextStyle(decoration: TextDecoration.underline)),
            )
          ],
        ),
      ),
    );
  }

  //
  // CAMPO DE TEXTO
  //
  Widget campoTexto(rotulo, variavelControle, tipoSenha, strvalidacao) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: tipoSenha,
        //keyboardType: TextInputType.number,
        controller: variavelControle,
        style: TextStyle(fontSize: 28),
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            fontSize: 18,
          ),
        ),
        validator: (value) {
          return (value.toString() == "") ? strvalidacao : null;
        },
      ),
    );
  }

  //
  // BOTÃO
  //
  Widget botao(rotulo) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      margin: EdgeInsets.symmetric(horizontal: 90),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.blue[600])),
        child: Text(
          rotulo,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          if (formKey.currentState.validate()) {
            setState(() {});

            var dados = Map();
            dados['txtUsuario'] = txtUsuario.text;
            dados['txtSenha'] = txtSenha.text;

            formKey.currentState.reset();
            Navigator.pushNamed(context, '/TelaPrincipal', arguments: dados);
          } else {
            debugPrint("Validar usuário e senha");
          }
        },
      ),
    );
  }
}
