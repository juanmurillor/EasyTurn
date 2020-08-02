import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_turn/src/screens/Comun/FooterSlider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';



class PedirTurnoPage extends StatefulWidget{

  PedirTurnoPage({this.auth, this.onSignedOut, this.caja});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final DocumentReference caja;
  @override
    State<StatefulWidget> createState () => new _PedirTurnoPage();

}
class _PedirTurnoPage extends State<PedirTurnoPage>{

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;

  void crearTurno() async{
    var currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference usuario = db.collection('usuarios').document(currentUser.uid);
    DocumentSnapshot userData = await usuario.get();
    var query = await db.collection('turnos')
        .where('usuario', isEqualTo: usuario)
        .where('caja', isEqualTo: widget.caja)
        .where("atendido", isEqualTo: false)
        .where("eliminado", isEqualTo: false)
        .getDocuments();
    if(query.documents.length == 0){
      DateTime now = DateTime.now(); //DateTime
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime tomorrow = DateTime(now.year, now.month, now.day +1 );

      var alldocs = await db.collection('turnos')
          .where('caja', isEqualTo: widget.caja)
          .where("fecha_atencion", isLessThan: Timestamp.fromDate(tomorrow))
          .where("fecha_atencion", isGreaterThanOrEqualTo: Timestamp.fromDate(today))
          .where("reservado" , isEqualTo: false)
          .getDocuments();
      print(alldocs);
      var data = {
        "caja": widget.caja,
        "usuario": usuario,
        "atendido": false,
        "fecha_atencion": Timestamp.fromDate(today),
         "fecha_creacion": Timestamp.fromDate(now),
        "turno":alldocs.documents.length + 1,
        "reservado":false,
        "nombre": userData.data["nombre"],
        "apellido": userData.data["apellido"],
        "email": userData.data["email"],
        "telefono": userData.data["telefono"],
        "eliminado" : false
      };
      db.collection('turnos').add(data).then((value) {
        _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Turno creado exitosamente',
            style: new TextStyle(
                color: Colors.white,
                fontFamily: 'Questrial',
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          ),
          backgroundColor: Color(0xFF01DF3A),
        ));
      });
    }else{
      _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Text(
          'Ya creaste un turno, Por favor espera ser atendido',
          style: new TextStyle(color: Colors.white,
              fontFamily: 'Questrial',
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFFFF0000),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
     body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Pedir Turno',style: TextStyle(
                color:Colors.white,fontSize: 25.0,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500),),
              
              backgroundColor: Colors.blue,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
              background: Image.network("https://i.ya-webdesign.com/images/movies-vector-cinema-ticket-3.png")
                
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
         
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
                        "Pide un turno",
                     style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                       fontFamily: 'Questrial'
                      ),
                      ),
                      onPressed: crearTurno,
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2012/04/16/11/51/printer-35651_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: crearTurno
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FooterSlider(),
          ) 
        
              ]),
              ),
          ],
        )
     ),     
    );
  }

    
}
