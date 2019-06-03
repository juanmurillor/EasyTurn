import 'dart:convert';
import 'dart:math';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_restaurantes/carrito_compras.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';

class RestaurantesPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final Map data;
  RestaurantesPage(this.data, {this.auth, this.onSignedOut});

  @override
  State<StatefulWidget> createState() => new _RestaurantesPage();
}

class _RestaurantesPage extends State<RestaurantesPage> {
  List data;
  final db = Firestore.instance;
  String id;

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "http://192.168.0.18:8080/easyturn/rest/controllers/productrestaurantes/getProductByRestaurant/${widget.data["idrestaurante"]}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[0]['nombreproducto']);

    return "success";
  }

  int _itemCount = 0;

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.lightBlue,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            expandedHeight: 250.0,
            pinned: false,
            flexibleSpace: new FlexibleSpaceBar(
              background: Image.network(
                "${widget.data["imagenrestaurante"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverAppBar(
            actions: <Widget>[
              new IconButton(
                alignment: Alignment.topLeft,
                icon: new Icon(
                  Icons.shopping_cart,
                  color: Colors.blue,
                  size: 40.0,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CarritoComprasPage())),
              ),
              new Column(
                children: <Widget>[new Text("      ")],
              )
            ],
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            expandedHeight: 30.0,
            pinned: true,
            elevation: 20,

            flexibleSpace: FlexibleSpaceBar(

              title: Text("                                   "+
                "${widget.data["nombrerestaurante"]}",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              titlePadding: EdgeInsetsDirectional.only(start: 13, bottom: 900),
              
            ),
            title: Text(""+

              "${widget.data["descripcionrestaurante"]}",

              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, index) {
                return new Container(
                  child: new Center(
                      child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Card(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        data[index]["imagenproducto"]),
                                    radius: 35,
                                  ),
                                ],
                              ),
                              new Column(
                                children: <Widget>[Text("          ")],
                              ),
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Wrap(
                                      spacing: 5.0,
                                      runSpacing: 5.0,
                                      direction: Axis.vertical,
                                      children: <Widget>[
                                        new Text(
                                            "${data[index]["nombreproducto"]}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.right),
                                        new Text(
                                          "Precio: ${data[index]["precioproducto"]}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w300),
                                          textAlign: TextAlign.right,
                                        ),
                                        new Row(
                                          children: <Widget>[
                                            Text('Cantidad: '),
                                            _itemCount != 0
                                                ? new IconButton(
                                                    icon:
                                                        new Icon(Icons.remove),
                                                    onPressed: () => setState(
                                                        () => _itemCount--),
                                                  )
                                                : new Container(),
                                            new Text(_itemCount.toString()),
                                            new IconButton(
                                                icon: new Icon(Icons.add),
                                                onPressed: () => setState(
                                                    () => _itemCount++))
                                          ],
                                        ),
                                        new RaisedButton.icon(
                                          icon: new Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.white),
                                          label: new Text(
                                            'Agregar',
                                            style: new TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          color: Colors.blue,
                                          onPressed: () async {
                                            String correoRestaruante =
                                                widget.data["email_Usuarios"];
                                            String nombreRestaruante =
                                                widget.data["nombrerestaurante"];
                                            int idRestaurante =
                                                widget.data["idrestaurante"];
                                            String nombresProducto =
                                                data[index]["nombreproducto"];
                                            int precioProducto =
                                                data[index]["precioproducto"];
                                            String imagenProducto =
                                                data[index]["imagenproducto"];

                                            FirebaseUser user =
                                                await FirebaseAuth.instance
                                                    .currentUser();

                                            String email;
                                            email = user.email;

                                            var batch = db.batch();
                                            var rng = new Random();
                                            var rdmDocument = new List.generate(
                                                12, (_) => rng.nextInt(100));

                                            var refe = db
                                                .collection('ShoppingCar')
                                                .document('$rdmDocument');
                                            print(rdmDocument);

                                            batch.setData(
                                                refe,
                                                {
                                                  'idRestaurante':
                                                      idRestaurante,
                                                  'correoRestaurante':
                                                      '$correoRestaruante',
                                                  'nombreRestaurante':
                                                      '$nombreRestaruante',
                                                  'nombreProducto':
                                                      '$nombresProducto',
                                                  'precioProducto':
                                                      precioProducto,
                                                  'emailUsuario': 
                                                      '$email',
                                                  'imagenProducto':
                                                      '$imagenProducto',
                                                  'cantidadProducto': _itemCount,
                                                  'totalPrecioProducto': _itemCount*precioProducto
                                                },
                                                merge: true);
                                            batch.commit();
                                          },
                                        )
                                      ])
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
                );
              },
              childCount: data == null ? 0 : data.length,
            ),
          )
        ],
      ),
    );
  }
}

class ListTileItem extends StatefulWidget {
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    new Row(
      children: <Widget>[
        _itemCount != 0
            ? new IconButton(
                icon: new Icon(Icons.remove),
                onPressed: () => setState(() => _itemCount--),
              )
            : new Container(),
        new Text(_itemCount.toString()),
        new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () => setState(() => _itemCount++))
      ],
    );
  }
}
