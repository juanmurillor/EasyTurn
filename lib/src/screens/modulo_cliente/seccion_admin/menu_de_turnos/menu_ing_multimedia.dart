import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_academic.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_financiera.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/pedir_turno_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/reservar_turno_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/lista_turnos_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/mis_turnos_academico.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/ing_multimedia/pedir_turno_ing_multimedia.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/ing_multimedia/lista_turnos_ing_multimedia.dart';



import 'package:flutter/material.dart';

class MenuIngMultimediaPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuIngMultimediaPage();


   

}
class _MenuIngMultimediaPage extends State<MenuIngMultimediaPage>{

  void moveToPedirTurnoIngMultimediaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PedirTurnoIngMultimediaPage()),
              );
  }
  void moveToReservarTurnoTurnoAcademicoPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReservarTurnoTurnoAcademicoPage()),
              );
  }
  void moveToListaTurnosIngMultimediaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaTurnosIngMultimediaPage()),
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
        title: Text("Ingenieria Multimedia",style: new TextStyle(
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
            onPressed: moveToPedirTurnoIngMultimediaPage,
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
            onPressed: moveToListaTurnosIngMultimediaPage
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
