import 'package:flutter/material.dart';
import 'configurar_restaurante_page.dart';
import '../login/auth.dart';
import 'lista_productos.dart';

class RestaurantePage extends StatefulWidget {
  RestaurantePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;


@override
  State<StatefulWidget> createState() => new _RestaurantePageState();

}

class _RestaurantePageState extends State<RestaurantePage>{

  void _signOut() async {

  try{
    await widget.auth.signOut();
    widget.onSignedOut();

  }catch (e){
    print (e);

  }
}


  void moveToConfigurarRestaurantePage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigurarRestaurantePage()),
              );
  }
  void moveToListaProductosPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaProductosPage()),
              );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido Restaurante"),
        actions: <Widget>[
            new FlatButton(
              child: new Text('Cerrar Sesion', style: new TextStyle(fontSize: 17.0, color: Colors.white),),
              onPressed: _signOut
            )
          ],
      ),
      body: new ListView(
        children: <Widget>[
          new RaisedButton(
            child: new Text('Lista de Restaurantes',
             style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
                  ),
                  color: Colors.blue,
                  onPressed: moveToConfigurarRestaurantePage,
          ),
          new RaisedButton(
            child: new Text('Lista de Productos',
             style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
                  ),
                  color: Colors.blue,
                  onPressed: moveToListaProductosPage,

          )
        ],
        
        ),
      );
  }
}
