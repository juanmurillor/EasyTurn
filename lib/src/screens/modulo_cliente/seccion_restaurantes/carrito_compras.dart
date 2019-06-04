import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class CarritoComprasPage extends StatefulWidget {
  CarritoComprasPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _CarritoComprasPageState createState() => _CarritoComprasPageState();
}

class _CarritoComprasPageState extends State<CarritoComprasPage> {
  final db = Firestore.instance;
  String id;

  void crearPedido() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String email;
    var listaUsuarios = [];
    email = user.email;
    String Nombre;
    String Apellido;

    Buscar().buscarusuario(email).then((QuerySnapshot docs2) async {
      for (int i = 0; i < docs2.documents.length; i++) {
        listaUsuarios.add(docs2.documents[i].data.values.toList());
        //print(docs.documents[i].data);
      }
      print("este es el nombresito " + listaUsuarios[0][3]);
      Nombre = listaUsuarios[0][3];
      Apellido = listaUsuarios[0][0];

      print("signed in" + user.email);

      var resultado = [];
      var resultadoJson = [];
      Map resultjason;
      Buscar().buscarCarrito(user.email).then((QuerySnapshot docs) async {
        for (int i = 0; i < docs.documents.length; i++) {
          resultjason = docs.documents[i].data;
          resultado.add(docs.documents[i].data);
          resultadoJson.add(docs.documents[i].data.toString());
          //print(docs.documents[i].data);

        }
        //print(resultado);
        //print(pedido.toString());
        // print("este es la lista "+resultado[0].toString());
        // print('Este es el resultadoJsn'+ resultadoJson.toString());

        //var pedidoMap =resultado[0];
        List pedidoUsuario = resultado;
        print(pedidoUsuario);
        Map dato ;
        dato = resultado[0];
        print(dato);
        print(dato['totalPrecioProducto']);
        String emailUsuario = email;
        String nombreUsuario = Nombre;
        String apellidoUsuario = Apellido;
        String pedidoAtendido = "NO";

        var batch = db.batch();
        var rng = new Random();
        var rdmDocument = new List.generate(12, (_) => rng.nextInt(100));

        var refe = db.collection('PedidosRestaurante').document('$rdmDocument');
        print(rdmDocument);

        batch.setData(
            refe,
            {
              'pedidoUsuario': '$pedidoUsuario',
              'emailUsuario': '$emailUsuario',
              'nombreUsuario': '$nombreUsuario',
              'apellidoUsuario': '$apellidoUsuario',
              'pedidoAtendido': '$pedidoAtendido',
              
            },
            merge: true);
        batch.commit();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Carrito de compras'),
      ),
      body: CarritoCompraList(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.receipt),
        label: Text("Realizar Pedido"),
        onPressed: crearPedido,
        isExtended: true,
      ),
    );
  }
}

class CarritoCompraList extends StatelessWidget {
  CarritoCompraList({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;


  var listaUsuarios = [];
  String Nombre;
  String Apellido;
  static String emailUsu = "";
  
    Future<String>  userEmail() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      emailUsu = user.email;
      //print(emailUsu);
      }
    borrarProducto(docId){
      Firestore.instance.collection('ShoppingCar').document(docId).delete().catchError((e){
        print(e);
      });

    }



      
  @override
  Widget build(BuildContext context) {
    userEmail();
    userEmail();
    print(emailUsu);
    return StreamBuilder<QuerySnapshot> (

      stream: Firestore.instance
          .collection('ShoppingCar')
          .where('emailUsuario', isEqualTo: emailUsu )
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
                                  NetworkImage(document["imagenProducto"]),
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
                                'restaurante: ${document['nombreRestaurante']}',
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
                            new Text(
                                'cantidad: ${document['cantidadProducto']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                            new Text(
                                'Precio Total: ${document['totalPrecioProducto']}',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                             new RaisedButton.icon(
                                          icon: new Icon(
                                              Icons.delete_forever,
                                              color: Colors.white),
                                          label: new Text(
                                            'Eliminar Producto',
                                            style: new TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          color: Colors.red,
                                          onPressed: () {
                                            borrarProducto(document.documentID);

                                          },
                                        )
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
