import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfigurarRestaurantePage extends StatefulWidget{

  @override
    State<StatefulWidget> createState() => new _ConfigurarRestaurantePage();


   

}
class _ConfigurarRestaurantePage extends State<ConfigurarRestaurantePage>{

     TextEditingController idRestaurante = new TextEditingController();
     TextEditingController descripcionRestaurante = new TextEditingController();
     TextEditingController emailUsuario = new TextEditingController();
     TextEditingController nombreRestaurante = new TextEditingController();
     TextEditingController telefonoRestaurante = new TextEditingController();
     TextEditingController urlFotoRestaurante = new TextEditingController();


     Future<http.Response> guardarRestaurante() async {
       var url =  "http://172.16.117.76:8080/easyturn/rest/controllers/restaurantes/saveRestaurantes"; 
       Map<String, dynamic> data = 
       {
         'nombreRestaurante': nombreRestaurante.text,
	       'idRestaurante': idRestaurante.text,
	       'descripcionRestaurante': descripcionRestaurante.text,
	       'emailUsuario': emailUsuario.text,
	       'urlFotoRestaurante': urlFotoRestaurante.text,
          'telefonoRestaurante': telefonoRestaurante.text	 
       };
       var Body = json.encode(data);
       var response = await http.post(Uri.parse(url),body: Body,headers:{
          "Accept": "application/json",
          "content-type": "application/json"
        } , encoding: Encoding.getByName("utf-8"));
          print("${response.body}");
          print("${response.statusCode}");
          print(Body);
          return response;
     }



  @override
    Widget build(BuildContext context) {
     return new Scaffold(
        appBar: new AppBar(
          title: new Text('Configuaracion Restaurante'),
        ),
        body: new ListView(padding: EdgeInsets.all(16.0), children: <Widget>[
          new Form(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: inputs() + buttons(),
            ),
          ),
        ]));
    }

    List<Widget> inputs() {
    
      return [
      new TextFormField(
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(labelText: 'Identificacion del Restaurante'),
          validator: (value) =>
              value.isEmpty ? 'la Identificacion no puede estar vacia' : null,
          controller: idRestaurante,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Nombre del restaurante'),
          validator: (value) =>
              value.isEmpty ? 'El Nombre del restaurante no puede estar vacio' : null,
              controller: nombreRestaurante,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Descripcion del Restaurante'),
          validator: (value) =>
              value.isEmpty ? 'La Descripcion Restaurante no puede estar vacia' : null,
              controller: descripcionRestaurante,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Email del usuario'),
          validator: (value) =>
              value.isEmpty ? 'El Email no puede estar vacio' : null,
              controller: emailUsuario,
        ),
        new TextFormField(
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(labelText: 'Telefono del Restaurante'),
          validator: (value) =>
              value.isEmpty ? 'El Telefono no puede estar vacio' : null,
              controller: telefonoRestaurante,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Foto'),
          validator: (value) =>
              value.isEmpty ? 'la Foto no puede estar vacia' : null,
              controller: urlFotoRestaurante,
        ),
      ];
    }

     List<Widget> buttons() {
      return [
        new RaisedButton(
          child: new Text(
            'Guardar restaurante',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w400),
          ),
          color: Colors.blue,
          onPressed: (){
            guardarRestaurante();

          }),
        
      ];
  }
}
