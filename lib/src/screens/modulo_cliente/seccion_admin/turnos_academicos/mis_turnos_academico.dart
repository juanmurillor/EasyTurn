import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';




class MisTurnosAcademicoPage extends StatefulWidget {
  MisTurnosAcademicoPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut; 



  @override
  _MisTurnosAcademicoPageState createState() => _MisTurnosAcademicoPageState();

}

class _MisTurnosAcademicoPageState extends State<MisTurnosAcademicoPage> {


   static String emailUsu = "";

  static String NombreTurnoRegurlarAca = "";
  static String ApellidoTurnoRegurlarAca = "";
  static  int TurnoRegurlarAca ;

   static String NombreTurnoReservadoAca = "";
   static String ApellidoTurnoReservadoAca = "";
   static int TurnoReservadoAca  ;
   static String Fecha = "";
   static String Hora  = "";
    
    final db = Firestore.instance;

   

  

  
  
    Future<String>  userEmail() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      emailUsu = user.email;
      //print(emailUsu);
      }

    void turnoRegularAcademico () async {
     var listaTurnosRegularAca = [];

    
    
    Buscar().buscarTurnoRegular(emailUsu).then((QuerySnapshot docs2)  {
      for (int i = 0; i < docs2.documents.length; i++) {
        listaTurnosRegularAca.add(docs2.documents[i].data.values.toList());
        print(docs2.documents[i].data);
        NombreTurnoRegurlarAca = listaTurnosRegularAca[0][0];
        ApellidoTurnoRegurlarAca = listaTurnosRegularAca[0][1];
        TurnoRegurlarAca = listaTurnosRegularAca[0][3];
      }
      
    });
    }
     void turnoReservadoAcademico() async {
       var listaTurnosReservadoAca =[];
    Buscar().buscarTurnoReservado(emailUsu).then((QuerySnapshot docs2) async {
      for (int i = 0; i < docs2.documents.length; i++) {
        listaTurnosReservadoAca.add(docs2.documents[i].data.values.toList());
        print(docs2.documents[i].data);
      }
      NombreTurnoReservadoAca = listaTurnosReservadoAca[0][0];
      ApellidoTurnoReservadoAca = listaTurnosReservadoAca[0][1];
      TurnoReservadoAca = listaTurnosReservadoAca[0][3];
      Fecha = listaTurnosReservadoAca[0][4];
      Hora = listaTurnosReservadoAca[0][5];
    });
    }
  
  

  @override
  Widget build(BuildContext context) {
    userEmail();
    turnoRegularAcademico();
    turnoReservadoAcademico();

    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Mis Turnos',style: TextStyle(
                color:Colors.white,fontSize: 25.0,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500),),
              backgroundColor: Colors.white,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network("https://cdn.pixabay.com/photo/2018/09/21/13/11/checklist-3693113_960_720.jpg")
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                turnoRegular(),
                turnoReservado(),
                Container(
                  height: 200,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

   Widget turnoRegular() {
    return Card(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Turno Regular",
                    style: TextStyle(fontSize: 25, color: Colors.white,
                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500,)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: AutoSizeText(
                    "Turno: $TurnoRegurlarAca",
                    style: TextStyle(fontSize: 40.0,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.blue[900],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Text(
                      "Nombre: $ApellidoTurnoRegurlarAca $NombreTurnoRegurlarAca",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }


  Widget turnoReservado() {
    return Card(
      color: Colors.orange,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Turno Reservado",
                    style: TextStyle(fontSize: 25, color: Colors.white,
                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500,)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    
                    "Turno: $TurnoReservadoAca \n Fecha: $Fecha \n Hora: $Hora",
                    style: TextStyle(fontSize: 40.0,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500,
                                
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.orange[900],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Text(
                      "Nombre: $ApellidoTurnoReservadoAca $NombreTurnoReservadoAca",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}