
import 'package:easy_turn/src/screens/modulo_cliente/seccion_restaurantes/carrito_compras.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_restaurantes/menu_restaurantes.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_restaurantes/pedidos_restaurante.dart';
import 'package:flutter/material.dart';

class MenuSeccRestaurantePage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuSeccRestaurantePage();


   

}
class _MenuSeccRestaurantePage extends State<MenuSeccRestaurantePage>{

  void moveToMenuRestaurantesPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuRestaurantesPage()),
              );
  }
  void moveToCarritoComprasPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarritoComprasPage()),
              );
  }
  void moveToMisPedidoPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PedidoRestaurante()),
              );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seccion Restaurantes", style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 23
        ),),
      ),
      body: new  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
            child: Container(
              child: FittedBox(
              child: Material(
               color: Colors.white ,
               elevation: 14.0,
               borderRadius: BorderRadius.circular(24.0),
               shadowColor: Color(0x802196F3),
               child: Row(
                 
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: new FlatButton(
                      child: new Text(
                        "Restaurantes",
                      style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                       fontFamily: 'Questrial'
                      ),
                      ),
                      )
                    ),
                    Container(
                      width: 300,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                           
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight,
                          image: NetworkImage("https://cdn.pixabay.com/photo/2014/09/17/20/26/restaurant-449952_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuRestaurantesPage,
            ),
          ), 
          
             Padding(
             padding: const EdgeInsets.all(16.0),
             child: new FlatButton(
            child: Container(
              child: FittedBox(
              child: Material(
               color: Colors.white ,
               elevation: 14.0,
               borderRadius: BorderRadius.circular(24.0),
               shadowColor: Color(0x802196F3),
               child: Row(
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: new FlatButton(
                       child: new Text(
                        "Mis Pedidos",
                      style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                       fontFamily: 'Questrial'
                      ),
                      ),
                      
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight,
                          image: NetworkImage("https://cdn.pixabay.com/photo/2017/02/18/11/00/checklist-2077020_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToCarritoComprasPage,
             ),
            )
          ],
      
          
      ),
    );
  }

    
}
