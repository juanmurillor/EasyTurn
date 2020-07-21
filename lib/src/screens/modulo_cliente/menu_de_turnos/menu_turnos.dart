import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_de_turnos/mis_turnos.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_de_turnos/pedir_turno.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_de_turnos/reservar_turno.dart';

import 'package:flutter/material.dart';

import 'lista_turnos.dart';

class MenuTurnosPage extends StatefulWidget{
  DocumentSnapshot documentSnapshot;
  MenuTurnosPage({Key key, @required this.documentSnapshot}):super(key:key);

  @override
    State<StatefulWidget> createState () => new _MenuTurnosPage();
}
class _MenuTurnosPage extends State<MenuTurnosPage>{

  void moveToPedirTurnoPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PedirTurnoPage(caja: widget.documentSnapshot.reference ,))
    );
  }

  void moveToReservarTurnoTurnoPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReservarTurnoPage(caja: widget.documentSnapshot ,))
    );
  }

  void moveToListaTurnosPage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListaTurnosPage(caja: widget.documentSnapshot ,))
    );
  }

  void moveToMisTurnospage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MisTurnosPage(caja: widget.documentSnapshot ,))
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turnos " + 
            (widget.documentSnapshot.data["docente"] == true ?  "Profesor" :StringUtils.capitalize(widget.documentSnapshot.data["nombre"])

            ),style: new TextStyle(
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
                        "Pedir un turno" + (widget.documentSnapshot.data["docente"] == true ? " con ${StringUtils.capitalize(widget.documentSnapshot.data["nombre"])}" :""),
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
            onPressed: moveToPedirTurnoPage,
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
                        "Reservar un turno"  + (widget.documentSnapshot.data["docente"] == true ? " con ${StringUtils.capitalize(widget.documentSnapshot.data["nombre"])}" :""),
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
            onPressed: moveToReservarTurnoTurnoPage,
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
                        "Ver listado de turnos"  + (widget.documentSnapshot.data["docente"] ==true ? " de ${StringUtils.capitalize(widget.documentSnapshot.data["nombre"])}" :""),
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
            onPressed: moveToListaTurnosPage
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2015/12/03/14/53/cinema-ticket-1075066_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
           onPressed: moveToMisTurnospage,
             ),
            )
          ],      
      ),
    );
  }

    
}
