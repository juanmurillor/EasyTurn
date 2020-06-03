import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_academic.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_financiera.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/pedir_turno_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/reservar_turno_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/lista_turnos_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/mis_turnos_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/ing_industrial/pedir_turno_ing_industrial.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/ing_industrial/lista_turnos_ing_industrial.dart';



import 'package:flutter/material.dart';

class MenuIngIndustrialPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuIngIndustrialPage();


   

}
class _MenuIngIndustrialPage extends State<MenuIngIndustrialPage>{

  void moveToPedirTurnoIngIndustrialPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PedirTurnoIngIndustrialPage()),
              );
  }
  void moveToReservarTurnoTurnoAcademicoPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReservarTurnoTurnoAcademicoPage()),
              );
  }
  void moveToListaTurnosIngIndustrialPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaTurnosIngIndustrialPage()),
              );
  }

  void moveToMisTurnosAcademicoPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MisTurnosAcademicoPage()),
              );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingenieria Industrial",style: new TextStyle(
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2013/07/12/15/34/ticket-150090_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToPedirTurnoIngIndustrialPage,
            ),
          ), 
          /*Padding(
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2017/05/15/23/48/survey-2316468_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToReservarTurnoTurnoAcademicoPage,
             ),
            ),*/
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/07/04/12/14/steps-1496523_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToListaTurnosIngIndustrialPage
             ),
            ),
            /* Padding(
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2015/12/03/14/53/cinema-ticket-1075066_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
           onPressed: moveToMisTurnosAcademicoPage,
             ),
             )*/
          ],      
      ),
    );
  }

    
}
