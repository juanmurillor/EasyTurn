import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_academic.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_financiera.dart';
import 'package:flutter/material.dart';

class MenuTurnosCajaPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuTurnosCajaPage();


   

}
class _MenuTurnosCajaPage extends State<MenuTurnosCajaPage>{

  void moveToMenuAreaCajasPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuAreaCajasPage()),
              );
  }
  void moveToMenuAreaFinancieraPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuAreaFinancieraPage()),
              );
  }
  void moveToMenuAreaAcademicaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuAreaAcademicaPage()),
              );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turnos Area de Cajas",style: new TextStyle(
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
                        "Pedir un turno",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/10/12/19/54/homework-1735644_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuAreaAcademicaPage,
            ),
          ), 
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
                        "Reservar un turno",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2018/02/15/09/48/paperwork-3154814_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuAreaFinancieraPage,
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
                        "Ver listado de turnos",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/12/06/04/26/cash-register-1885558_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuAreaCajasPage,
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
                        "Mis Turnos",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/12/06/04/26/cash-register-1885558_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuAreaCajasPage,
             ),
            )
          ],
      
          
      ),
    );
  }

    
}
