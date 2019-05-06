import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestaurantesPage extends StatefulWidget{
  final Map data;
  RestaurantesPage(this.data);


  @override
    State<StatefulWidget> createState () => new _RestaurantesPage();


   

}
class _RestaurantesPage extends State<RestaurantesPage>{
 
 

    
  @override
    Widget build(BuildContext context) {
     return new Scaffold(
        appBar: new AppBar(
          title: new Text("${widget.data["nombrerestaurante"]}"),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            new Container(
              height: 200,
              width: 250,
              child: new Material(
                child: new Image.network("${widget.data["imagenrestaurante"]}",
                fit: BoxFit.cover,
                alignment: Alignment.center,
                ),
              ),

            ),
            new Divider(),
            new Container(
              padding: new EdgeInsets.all(10.0),
            
              child: new Row(
                children: <Widget>[

                  new Row(
                    children: <Widget>[
                      new Text("    ")
                    ],

                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("${widget.data["nombrerestaurante"]}",
                      style: new TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w900
                
                      ),
                      ),
                      new Text("${widget.data["descripcionrestaurante"]}",
                      style: new TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300
                      ),
                      ),
                    ],
                  ),                  
                ],
              ),
            ),
            new Divider(),
             new Container(
              padding: new EdgeInsets.all(10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  new Row(
                    children: <Widget>[
                      new Text("    ")
                    ],

                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("Lista de productos",
                      style: new TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w900
                
                      ),
                      ),
                      
                    ],
                  ),                  
                ],
              ),
            ),
           

          ],
        )

          

     );
    }
}

