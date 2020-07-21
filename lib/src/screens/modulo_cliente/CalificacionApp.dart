import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CalificacionAppPage extends StatefulWidget {
  CalificacionAppPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _CalificacionAppPage createState() => _CalificacionAppPage();
}

class _CalificacionAppPage extends State<CalificacionAppPage> {
  var calified = false;

  TextEditingController _controllerInputComentario;

  FirebaseAuth auth = FirebaseAuth.instance;

  var myFeedbackText = "ES BUENO";
  var comentario = "";
  var sliderValue = 2.5;
  IconData myFeedback = FontAwesomeIcons.smile;
  Color myFeedbackColor = Colors.yellow;

  final GlobalKey<ScaffoldState> _scaffoldState =
  new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;

  String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadComent();
  }

  void loadComent() async{
    _controllerInputComentario = new TextEditingController();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    db.collection('comentarios').document(user.uid).get().then((document){
      if(!document.exists){
        setState(() {
          calified = false;
        });
      }else{
        _controllerInputComentario.text = document.data["comentario"];
        setState(() {
          calified=true;
          comentario = document.data["comentario"];
          sliderValue = document.data["calificacion"];
        });
      }
    });
  }
  void crearCalificacion() async {
    if (comentario == "" || comentario == null) {
      _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Text(
          'El comentario es obligatorio',
          style: new TextStyle(
              color: Colors.white,
              fontFamily: 'Questrial',
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFFFF0000),
      ));
      return;
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var ref = db.collection('comentarios').document(user.uid);
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    var body = {'calificacion': sliderValue, 'comentario': comentario, 'date': myTimeStamp};
    if (calified) {
      ref.updateData(body).then((snap) {
        calified=true;
        _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Gracias por tu calificacion',
            style: new TextStyle(
                color: Colors.white,
                fontFamily: 'Questrial',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Color(0xFF01DF3A),
        ));
      });
    } else {
      ref.setData(body).then((snap) {
        setState(() {
          calified=true;
        });
        _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Gracias por tu calificacion',
            style: new TextStyle(
                color: Colors.white,
                fontFamily: 'Questrial',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: Color(0xFF01DF3A),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),

          //
        ),
        title: Text("Feedback"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    child: Text(
                      "Es muy importante para nosotros conocer la opinion de nuestros usuarios, Califica como te parecio nuestro servicio",
                      style: TextStyle(
                          color: Colors.green[500],
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Questrial'),
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
            Container(
              child: Align(
                child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Container(
                      width: 350.0,
                      height: 400.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Text(
                                  myFeedbackText,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22.0),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Icon(
                                  myFeedback,
                                  color: myFeedbackColor,
                                  size: 100.0,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Slider(
                                min: 0,
                                max: 5,
                                divisions: 4,
                                value: sliderValue,
                                activeColor: Color(0xffe05f2c),
                                inactiveColor: Colors.blueGrey,
                                onChanged: (newValue) {
                                  setState(() {
                                    sliderValue = newValue;
                                    if (sliderValue >= 0.0 &&
                                        sliderValue <= 1.0) {
                                      myFeedback = FontAwesomeIcons.sadTear;
                                      myFeedbackColor = Colors.red;
                                      myFeedbackText =
                                      "PODRIA MEJORAR BASTANTE";
                                    }
                                    if (sliderValue >= 2.1 &&
                                        sliderValue <= 3.0) {
                                      myFeedback = FontAwesomeIcons.smile;
                                      myFeedbackColor = Colors.yellow;
                                      myFeedbackText = "ES BUENO";
                                    }
                                    if (sliderValue >= 3.1 &&
                                        sliderValue <= 4.0) {
                                      myFeedback = FontAwesomeIcons.laugh;
                                      myFeedbackColor = Colors.green;
                                      myFeedbackText = "ES EXELENTE";
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: _controllerInputComentario,
                                  decoration: InputDecoration(
                                      labelText:
                                      "Deja un comentario sobre el servicio",
                                      hintText: "Comentario",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(4.0))),
                                  onChanged: (text) {
                                    setState(() {
                                      comentario = text;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0)),
                                      color: Color(0xffe05f2c),
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontFamily: 'Questrial'),
                                      ),
                                      onPressed: crearCalificacion),
                                )),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
