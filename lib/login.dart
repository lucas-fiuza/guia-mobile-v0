import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  //Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  var txtSenha = TextEditingController();
  String txtId = "";
  String txtName = "";
  String senha = "";
  var txtEmail = TextEditingController();

  var db = FirebaseFirestore.instance;

  //Recuperar um DOCUMENTO a partir do ID
  getUserValid(String email, String senha) async {

    try {
      QuerySnapshot querySnapshot = await db.collection("users").get();

      DocumentSnapshot document = querySnapshot.docs.firstWhere(
          (DocumentSnapshot documentSnapshot) =>
              documentSnapshot['email'] == email);

      if (document.exists) {
        
        txtId = document.id;
        txtName = document['name'];
        senha = document['password'];

        if (txtSenha.text != senha) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Senha inválida!'),
            backgroundColor: Colors.red,
          ));

        } else {
          var dados = Map();
          dados['txtUsuario'] = txtName;
          dados['txtId'] = txtId;

          formKey.currentState.reset();
          txtName = "";
          txtId = "";
          Navigator.pushNamed(context, '/TelaPrincipal', arguments: dados);
        }
      }
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Usuario não encontrado!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      key: _scaffoldKey,
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
                    campoTexto("E-mail", txtEmail, false, "Digite sua e-mail"),
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
        onPressed: () async {
          if (formKey.currentState.validate()) {
            await getUserValid(txtEmail.text, txtSenha.text);
          } else {
            debugPrint("Validar usuário e senha");
          }
        },
      ),
    );
  }
}
