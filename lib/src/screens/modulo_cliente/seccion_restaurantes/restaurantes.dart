import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RestaurantesPage extends StatefulWidget {
  final Map data;
  RestaurantesPage(this.data);

  @override
  State<StatefulWidget> createState() => new _RestaurantesPage();
}

class _RestaurantesPage extends State<RestaurantesPage> {
  List data;

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull(
            "http://172.16.101.12:8080/easyturn/rest/controllers/productrestaurantes/getProductByRestaurant/${widget.data["idrestaurante"]}"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[0]['nombreproducto']);

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
            
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            expandedHeight: 20,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "${widget.data["nombrerestaurante"]}",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              titlePadding: EdgeInsetsDirectional.only(start: 13, bottom: 40),
            ),
            title: Text(
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
                  child: FlatButton(
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
                                      radius: 30,
                                    ),
                                  ],
                                ),
                                new Column(
                                  children: <Widget>[Text("  ")],
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
                                        ])
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
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
