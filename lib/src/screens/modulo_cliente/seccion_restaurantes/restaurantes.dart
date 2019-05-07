import 'dart:convert';
import 'package:flutter/material.dart';
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
            "http://192.168.0.18:8080/easyturn/rest/controllers/productrestaurantes/getProductByRestaurant/${widget.data["idrestaurante"]}"),
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
      appBar: new AppBar(
        title: new Text("data"),
      ),
        body: new CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              flexibleSpace: new FlexibleSpaceBar(
                background: Image.network("${widget.data["imagenrestaurante"]}"),
              ),
            ),
            new SliverList(
              delegate:  new SliverChildBuilderDelegate(
                (context, index){
                  return ListTile(title: Text("${data[index]["nombreproducto"]}")
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
