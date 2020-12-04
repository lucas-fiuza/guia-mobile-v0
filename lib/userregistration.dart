import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TelaCadastroUsuario extends StatefulWidget {
  @override
  _TelaCadastroUsuarioState createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  String pageTitle = "Cadastro";
  bool showDelete = false;

  var formUserKey = GlobalKey<FormState>();

  var txtSenha = TextEditingController();
  var txtUsuario = TextEditingController();
  var txtEmail = TextEditingController();
  var txtApelido = TextEditingController();

  var db = FirebaseFirestore.instance;

  //Recuperar um DOCUMENTO a partir do ID
  void getDocumentById(String id) async {
    await db.collection("users").doc(id).get().then((doc) {
      txtSenha.text = doc.data()['password'];
      txtUsuario.text = doc.data()['name'];
      txtEmail.text = doc.data()['email'];
      txtApelido.text = doc.data()['nickname'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;

    if (id != null) {
      if (txtSenha.text == '' &&
          txtUsuario.text == '' &&
          txtEmail.text == '' &&
          txtApelido.text == '') {
        pageTitle = "Perfil";
        showDelete = true;
        getDocumentById(id);
      }
    } else {
      showDelete = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: formUserKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.blue),
                      title: TextFormField(
                        controller: txtUsuario,
                        decoration: InputDecoration(labelText: "Usuário"),
                        validator: (value) {
                          return (value.toString() == "")
                              ? "Informe o nome."
                              : null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: ListTile(
                      leading: Icon(Icons.insert_emoticon, color: Colors.blue),
                      title: TextFormField(
                        controller: txtApelido,
                        decoration: InputDecoration(labelText: "Apelido"),
                        validator: (value) {
                          return (value.toString() == "")
                              ? "Informe o Apelido."
                              : null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: ListTile(
                      leading: Icon(Icons.email, color: Colors.blue),
                      title: TextFormField(
                        controller: txtEmail,
                        decoration: InputDecoration(labelText: "E-mail"),
                        validator: (value) {
                          return (value.toString() == "")
                              ? "Informe o e-mail."
                              : null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: ListTile(
                      leading: Icon(Icons.vpn_key, color: Colors.blue),
                      title: TextFormField(
                        controller: txtSenha,
                        decoration: InputDecoration(labelText: "Senha"),
                        validator: (value) {
                          return (value.toString() == "")
                              ? "Informe a senha."
                              : null;
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ),
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
                    "Voltar",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    formUserKey.currentState.reset();
                    Navigator.pop(context);
                  }),
              RaisedButton.icon(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue[600])),
                  label: Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    debugPrint(id);
                    if (formUserKey.currentState.validate()) {
                      if (id == null) {
                        debugPrint(id);
                        debugPrint("Entrou");
                        //ADICIONAR um novo DOCUMENTO a COLEÇÃO
                        db.collection("users").add({
                          "name": txtUsuario.text.toString(),
                          "nickname": txtApelido.text.toString(),
                          "password": txtSenha.text.toString(),
                          "email": txtEmail.text.toString()
                        });
                      } else {
                        //ATUALIZAR dados do DOCUMENTO
                        db.collection("users").doc(id).update({
                          "name": txtUsuario.text.toString(),
                          "nickname": txtApelido.text.toString(),
                          "password": txtSenha.text.toString(),
                          "email": txtEmail.text.toString()
                        });
                      }
                      setState(() {
                        if (id == null) {
                          caixaDialogo(txtApelido.text + ", bem vindo!",
                              "Seu cadastro foi efetuado com sucesso!");
                        } else {
                          caixaDialogo(txtApelido.text,
                              "Seu cadastro foi atualizado com sucesso!");
                        }
                      });
                      formUserKey.currentState.reset();
                    }
                  }),
              Visibility(
                visible: showDelete,
                child: Expanded(
                  child: RaisedButton.icon(
                      color: Colors.red[600],
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue[600])),
                      label: Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.restore_from_trash,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        formUserKey.currentState.reset();

                        db.collection("users").doc(id).delete();

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }),
                ),
              )
            ],
          ),
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('fechar'))
            ],
          );
        });
  }
}
