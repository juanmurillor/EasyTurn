import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_turn/src/screens/Comun/FooterSlider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';


class ListaTurnosPage extends StatefulWidget {
  ListaTurnosPage({this.auth, this.onSignedOut, @required this.caja, this.ready:false});
  final DocumentSnapshot caja;
  final bool ready;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => new _ListaTurnosPage();
}

class _ListaTurnosPage extends State<ListaTurnosPage> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;
  static DateTime now = DateTime.now(); //DateTime
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime tomorrow = DateTime(now.year, now.month, now.day +1 );
  String id;
  int eta = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEta();
    if(widget.ready == true){
      WidgetsBinding.instance
          .addPostFrameCallback((_) => isReady(context));
    };
  }
  void getEta() async {
    FirebaseUser user = await  FirebaseAuth.instance.currentUser();
    widget.caja.reference.snapshots().listen((snap) {
      DocumentReference userref = Firestore.instance.collection("usuarios").document(user.uid);

      //obtenemos nuestro turno
      Firestore.instance
          .collection('turnos')
          .where('caja', isEqualTo: widget.caja.reference)
          .where("fecha_atencion", isGreaterThanOrEqualTo: Timestamp.fromDate(today))
          .where("fecha_atencion", isLessThan: Timestamp.fromDate(tomorrow))
          .where("atendido", isEqualTo: false)
          .where("eliminado", isEqualTo: false)
          .snapshots().listen((event) {
            int total = 0;
            for(int i=0; i < event.documents.length;i++){
              if(event.documents[i].data["usuario"] == userref){
                break;
              }
              total++;
            }
            setState(() {
              eta = total* snap.data["tiempoEstimado"];
            });
      });
    });
  }
  void isReady(context){
    print(widget.caja.data.toString());
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Tu turno ya esta listo"),
          content: new Text("Es tu turno " +
              ((widget.caja.reference.path.contains('secciones/cajas/subareas/*/') != null) ? "en la caja" : "con el profesor") ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new FlatButton(
              child: new Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          widget.caja.data["tipoUsuario"] == "profesor"
              ? "Turnos Profesor"
              : "Turnos " + StringUtils.capitalize(widget.caja.data["nombre"]),
          style: new TextStyle(fontFamily: 'FugazOne', fontSize: 23),
        ),
      ),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
              .collection('turnos')
              .where('caja', isEqualTo: widget.caja.reference)
              .where("fecha_atencion", isGreaterThanOrEqualTo: Timestamp.fromDate(today))
              .where("fecha_atencion", isLessThan: Timestamp.fromDate(tomorrow))
              .where("atendido", isEqualTo: false)
              .where("eliminado", isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (snapshot.data == null || snapshot.data.documents.isEmpty)
            return new Text('   \n  No hay turnos en espera actualmente',
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center);

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return Container(
                child: new Column(
                  children: [
                    Card(
                      child: Padding(
                padding: const EdgeInsets.all(30.0),
                        child:                       Text("Tiempo estimado de atención ${eta} minutos"),


              ),
                    ),
                    Flexible(
                      child: new ListView(
                        children:
                        snapshot.data.documents.map((DocumentSnapshot document) {
                          return new Card(
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(document["reservado"] ?
                                        'Hora: ${document["hora_atencion"]} '
                                            :'Turno: ${document['turno']}',
                                            style: TextStyle(
                                                fontSize: 50.0,
                                                fontFamily: 'Questrial',
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.right),
                                      ]),
                                  new Row(
                                    children: <Widget>[new Text("     ")],
                                  ),
                                  new Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text('Nombre: ${StringUtils.capitalize(document['nombre'])}',
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              fontFamily: 'Questrial',
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.right),
                                    ],
                                  ),
                                  new Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Text('Apellido: ${StringUtils.capitalize(document['apellido'])}',
                                            style: TextStyle(
                                                fontSize: 30.0,
                                                fontFamily: 'Questrial',
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.right),
                                      ])
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              );
          }
        },
      ),
      bottomSheet: FooterSlider(),
    );
  }

}
