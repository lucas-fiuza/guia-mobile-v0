import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guia_comercial_mobile/component/listViewStore.dart';
import 'package:guia_comercial_mobile/login.dart';
import 'package:guia_comercial_mobile/about.dart';
import 'package:guia_comercial_mobile/shared/storeDto.dart';
import 'package:guia_comercial_mobile/store.dart';
import 'package:guia_comercial_mobile/userregistration.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Catálogo Comercial',
    initialRoute: '/TelaLogin',
    routes: {
      '/TelaLogin': (context) => TelaLogin(),
      '/TelaPrincipal': (context) => TelaPrincipal(),
      '/TelaSobre': (context) => TelaSobre(),
      '/TelaCadastroUsuario': (context) => TelaCadastroUsuario(),
      '/TelaLoja' : (context) => TelaLoja(),
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
              ),
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
            child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/json/listStore.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Commerce> lojas = listaLojas(snapshot.data.toString());
                    return StoreList(store: lojas);
                  } else {
                    return new Center(child: new CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }
}

List<Commerce> listaLojas(String jsonString) {
  if (jsonString == null) {
    return [];
  }

  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<Commerce>((json) => new Commerce.fromJson(json)).toList();
}
