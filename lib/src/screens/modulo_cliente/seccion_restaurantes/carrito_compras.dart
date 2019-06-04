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

   final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

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
        var pedidos=[];
        List pedidoUsuario = resultado;
        for(int i = 0; i<pedidoUsuario.length; i++){
          pedidos.add(pedidoUsuario[i]);
        }
        
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
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Carrito de compras',style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 23
        ),),
      ),
      body: CarritoCompraList(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.receipt),
        label: Text("Realizar Pedido",style: new TextStyle(
          fontFamily: 'Questrial',
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),),
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

   final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();


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
              key: _scaffoldState,
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
                                'Restaurante: ${document['nombreRestaurante']}',
                                style: TextStyle(
                                    fontFamily: 'Questrial',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right),
                            new Text('Producto: ${document['nombreProducto']}',
                                style: TextStyle(
                                  fontFamily: 'Questrial',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right),
                            new Text('Precio: ${document['precioProducto']}',
                                style: TextStyle(
                                  fontFamily: 'Questrial',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right),
                            new Text(
                                'Cantidad: ${document['cantidadProducto']}',
                                style: TextStyle(
                                  fontFamily: 'Questrial',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right),
                            new Text(
                                'Precio Total: ${document['totalPrecioProducto']}',
                                style: TextStyle(
                                  fontFamily: 'Questrial',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right),
                             new RaisedButton.icon(
                                          icon: new Icon(
                                              Icons.delete_forever,
                                              color: Colors.white),
                                          label: new Text(
                                            'Eliminar Producto',
                                            style: new TextStyle(
                                              fontFamily: 'Questrial',
                                                fontSize: 17.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          color: Colors.red,
                                          onPressed: () {
                                            borrarProducto(document.documentID);
                                             _scaffoldState.currentState
                                                  .showSnackBar(new SnackBar(
                                                content: new Text(
                                                  'Producto eliminado exitosamente',
                                                  style: new TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Questrial',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                backgroundColor:
                                                    Color(0xFF01DF3A),
                                              ));

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
