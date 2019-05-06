import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfigurarRestaurantePage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _ConfigurarRestaurantePage();


   

}
class _ConfigurarRestaurantePage extends State<ConfigurarRestaurantePage>{
 List data;

Future<String>getData() async{
  http.Response response =await http.get(
  Uri.encodeFull("http://172.16.109.249:8080/easyturn/rest/controllers/restaurante/getDataRestaurante"),
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
          title: new Text('Restaurantes'),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(data[index]["imagenrestaurante"]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[index]["nombrerestaurante"]),
                            )
                          ],
                        ),
                       
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

