import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guia_comercial_mobile/component/listViewStore.dart';
import 'package:guia_comercial_mobile/login.dart';
import 'package:guia_comercial_mobile/about.dart';
import 'package:guia_comercial_mobile/shared/storeDto.dart';
import 'package:guia_comercial_mobile/store.dart';
import 'package:guia_comercial_mobile/suggestion.dart';
import 'package:guia_comercial_mobile/userregistration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Catálogo Comercial',
    initialRoute: '/TelaLogin',
    routes: {
      '/TelaLogin': (context) => TelaLogin(),
      '/TelaPrincipal': (context) => TelaPrincipal(),
      '/TelaSobre': (context) => TelaSobre(),
      '/TelaCadastroUsuario': (context) => TelaCadastroUsuario(),
      '/TelaLoja': (context) => TelaLoja(),
      '/TelaSugestao': (context) => TelaSugestao(),
    },
  ));
}

//
//TELA PRINCIPAL
//
class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  var db = FirebaseFirestore.instance;

  //Lista Dinâmica de objetos da classe Café
  List<Commerce> lojas = List();

  //Declaração de um objeto "ouvinte" da coleção Cafés do Firestore
  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState() {
    super.initState();

    //Registrar o "ouvidor" para monitorar qualquer tipo de alteração
    ouvidor?.cancel();

    ouvidor = db.collection("commerce").snapshots().listen((res) {
      setState(() {
        lojas = res.docs.map((e) => Commerce.fromMap(e.data(), e.id)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Map dadosLogin = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("Catálogo Comercial"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  dadosLogin['txtUsuario'].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.account_box),
                  title: Text('Perfil'),
                  onTap: () {
                    Navigator.pushNamed(context, "/TelaCadastroUsuario",
                        arguments: dadosLogin['txtId']);
                  }),
              ListTile(
                  leading: Icon(Icons.question_answer_outlined),
                  title: Text('Sugestão'),
                  onTap: () {
                    Navigator.pushNamed(context, "/TelaSugestao", arguments: dadosLogin['txtId']);
                  }),
              ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Sobre'),
                  onTap: () {
                    Navigator.pushNamed(context, "/TelaSobre");
                  }),
              ListTile(
                leading: Icon(Icons.west_outlined),
                title: Text('Sair'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: Center(
            child: StreamBuilder<QuerySnapshot>(
                stream: db.collection("commerce").snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Center(
                          child: Text("Erro ao conectar no Firebase"));
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      return StoreList(store: lojas);
                  }
                }),
          ),
        ));
  }
}
