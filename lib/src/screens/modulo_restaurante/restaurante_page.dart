import 'package:flutter/material.dart';
import 'configurar_restaurante_page.dart';

class RestauranteRoute extends StatefulWidget {

@override
  State<StatefulWidget> createState() => new _RestauranteRouteState();

}

class _RestauranteRouteState extends State<RestauranteRoute>{


  void moveToConfigurarRestaurantePage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigurarRestaurantePage()),
              );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido Restaurante"),
      ),
      body: Container(
        child: Center(
          child: new RaisedButton(
            child: new Text('Configurar Restaurante',
             style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
                  ),
                  color: Colors.blue,
                  onPressed: moveToConfigurarRestaurantePage,
            
          )
          /*child: RaisedButton(
            onPressed: () {
              // Navigate back to first route when tapped.
            },
            //child: Text('Go back!'),
          ),*/
        ),
      ),
    );
  }
}
