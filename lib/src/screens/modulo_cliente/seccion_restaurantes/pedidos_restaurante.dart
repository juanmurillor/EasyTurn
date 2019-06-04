import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';


class PedidoRestaurante extends StatefulWidget {
  PedidoRestaurante({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _PedidoRestauranteState createState() => _PedidoRestauranteState();
}


class _PedidoRestauranteState extends State<PedidoRestaurante> {
  final db = Firestore.instance;
  String id;

  @override
  Widget build(BuildContext context) {
     return new Scaffold(
      appBar: AppBar(
        title: Text('Mis Pedidos'),
      ),
      body: CarritoCompraList(),
     
    );
  }
}
class CarritoCompraList extends StatelessWidget {
  CarritoCompraList({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  static String emailUsu = "";
  
    Future<String>  userEmail() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      emailUsu = user.email;
      //print(emailUsu);
      }

  @override
  Widget build(BuildContext context) {
   userEmail();
    userEmail();
    print(emailUsu);

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('PedidosRestaurante')
          .where('emailUsuario', isEqualTo: emailUsu)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage("https://cdn.pixabay.com/photo/2017/06/10/07/18/list-2389219_960_720.png"),
                              radius: 35,
                            ),
                          ],
                        ),
                        new Column(
                          children: <Widget>[Text("          ")],
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                'Nombre: ${document['nombreUsuario']} ${document['apellidoUsuario']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                            new Text('Email: ${document['emailUsuario']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                          
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}