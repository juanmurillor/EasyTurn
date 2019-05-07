import 'dart:convert';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_restaurantes/restaurantes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MenuRestaurantesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MenuRestaurantesPage();
}

class _MenuRestaurantesPage extends State<MenuRestaurantesPage> {
  List data;

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "http://172.16.101.12:8080/easyturn/rest/controllers/restaurante/getDataRestaurante"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[0]['nombrerestaurante']);

    return "success";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Restaurantes'),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: FlatButton(
                child: new Center(
                    child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Column(children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  data[index]["imagenrestaurante"]),
                              radius: 50,
                            ),
                          ]),
                          new Column(
                            children: <Widget>[Text("    ")],
                          ),
                          new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text(
                                        "${data[index]["nombrerestaurante"]}",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.right),
                                    new Text(
                                      "${data[index]["descripcionrestaurante"]}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w300),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                  /*Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "${data[index]["nombrerestaurante"]}",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w700),
                            ),
                          ),*/
                                ),
                              ]),
                        ],
                      ),
                    ))
                  ],
                )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RestaurantesPage(data[index])),
                  );
                },
              ),
            );
          },
        ));
  }
}
