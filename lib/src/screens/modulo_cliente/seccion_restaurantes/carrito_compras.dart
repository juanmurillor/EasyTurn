import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CarritoComprasPage extends StatefulWidget {

  @override
  _CarritoComprasPageState createState() => _CarritoComprasPageState();
}



class _CarritoComprasPageState extends State<CarritoComprasPage> {

  

  

 Future<String> currentUser() async {
    FirebaseUser user = await  FirebaseAuth.instance.currentUser();
    return user.email;
  }

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Carrito de compras'),
      ),
      body: new CarritoCompraList()


    );
  }
}
class CarritoCompraList extends StatelessWidget {
   CarritoCompraList({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  

  @override
  Widget build(BuildContext context) {

    

    
    


    return StreamBuilder<QuerySnapshot>(
      

      stream: Firestore.instance
          .collection('ShoppingCar').where('emailUsuario', isEqualTo: 'muriillor@gmail.com' ).snapshots(),
          
          
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
                                    backgroundImage: NetworkImage(
                                        document["imagenProducto"]),
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
                            new Text('restaurante: ${document['nombreRestaurante']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                            new Text('producto: ${document['nombreProducto']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                            new Text('precio: ${document['precioProducto']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                             new Text('cantidad: ${document['cantidadProducto']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),    
                          ],
                        )
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