import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';

class MisTurnosPage extends StatefulWidget {
  MisTurnosPage({this.auth, this.onSignedOut, @required this.caja});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final DocumentSnapshot caja;

  @override
  _MisTurnosPage createState() => _MisTurnosPage();
}

class _MisTurnosPage extends State<MisTurnosPage> {
  DocumentSnapshot turno = null;

  final db = Firestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTurnos();
  }

  void obtenerTurnos() async {
    var currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference usuario =
        db.collection('usuarios').document(currentUser.uid);
    print("obtener");
    var query = await db
        .collection('turnos')
        .where('usuario', isEqualTo: usuario)
        .where('caja', isEqualTo: widget.caja.reference)
        .where("atendido", isEqualTo: false)
        .where("eliminado", isEqualTo: false)
        .getDocuments();
    if (query.documents.length > 0) {
      setState(() {
        turno = query.documents[0];
      });
    }else{
      setState(() {
        turno = null;
      });
    }
  }

  String timestampToDate(Timestamp timestamp) {
    DateTime date = DateTime.parse(timestamp.toDate().toString());
    var day = date.day < 10 ? "0${date.day.toString()}" : date.day.toString();
    var month =
        date.month < 10 ? "0${date.month.toString()}" : date.month.toString();
    var year =
        date.year < 10 ? "0${date.year.toString()}" : date.year.toString();
    return "$day/$month/$year";
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("¿Deseas cancelar tu turno?'"),
          content: new Text("Si cancelas tu turno tendras que volver a hacer la cola desde el comienzo"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              color: Color(0xFFFF0000),
              child: new Text("Eliminar turno"),
              onPressed: () {
                Navigator.of(context).pop();
                turno.reference.updateData({
                  "eliminado": true
                }).then((value){
                  obtenerTurnos();
                });
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
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Mis Turnos',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: Colors.white,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                      "https://cdn.pixabay.com/photo/2018/09/21/13/11/checklist-3693113_960_720.jpg")),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                turno == null
                    ? Text('   \n  No hay turnos en espera actualmente',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Questrial',
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center)
                    : turno["reservado"]
                        ? turnoReservado(turno.data)
                        : turnoRegular(turno.data),
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

  Widget turnoRegular(var documento) {
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
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w500,
                    )),
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
                    "Turno: ${documento["turno"]}",
                    style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Questrial',
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                  ),
                ),

              ],
            ),
          ),
          Container(
            color: Colors.blue[900],
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Nombre: ${StringUtils.capitalize(documento["nombre"])} ${StringUtils.capitalize(documento["apellido"])}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: _showDialog,
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget turnoReservado(var documento) {
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
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w500,
                    )),
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
                    "Fecha: ${timestampToDate(documento["fecha_atencion"])} \n Hora: ${documento["hora_atencion"]}",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.orange[900],
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Nombre: ${StringUtils.capitalize(documento["nombre"])} ${StringUtils.capitalize(documento["apellido"])}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.white  ,),
                      onPressed: _showDialog,
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
