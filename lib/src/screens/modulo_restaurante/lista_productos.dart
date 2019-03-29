import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaProductosPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState() => new _ListaProductosPage();


   

}
class _ListaProductosPage extends State<ListaProductosPage>{
 List data;
Future<String>getData() async{
  http.Response response =await http.get(
  Uri.encodeFull("http://192.168.1.69:8080/easyturn/rest/controllers/productrestaurantes/getDataProductrestaurantes"),
   headers: {"Accept": "application/json"}
  );

this.setState((){
  data =json.decode(response.body);
});




 
  print(data[0]['nombrerestaurante']);

  return "success";
  
}


  @override
  void initState(){

    super.initState();
    this.getData();

  }

 

    
  @override
    Widget build(BuildContext context) {
     return new Scaffold(
        appBar: new AppBar(
          title: new Text('Lista de Productos'),
        ),
        body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index ){
            return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                      child: new Container(
                        child: Text("nombre del producto: ${data[index]["nombreproducto"]} | Precio: ${data[index]["precioproducto"]} COP "),
                
                        padding: const EdgeInsets.all(20.0),
                      )
                    )
                  ],
                )
              ),

            );
          },
        ));
    }

  
}