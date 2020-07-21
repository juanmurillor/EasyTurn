import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ReservarTurnoPage extends StatefulWidget {
  ReservarTurnoPage({this.auth, this.onSignedOut, this.caja});
  final DocumentSnapshot caja;
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => new _ReservarTurnoPage();
}

class _ReservarTurnoPage extends State<ReservarTurnoPage> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;

  String id;

  String _date = "Selecciona Una Fecha";
  DateTime date;
  String valueSelected;
  List<String> _horas = [];

  void crearTurno() async{
    if(valueSelected == null){
      _scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Text(
          'Debes seleccionar un dia y fecha',
          style: new TextStyle(color: Colors.white,
              fontFamily: 'Questrial',
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFFFF0000),
      ));
      return;
    }
    var currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference usuario = db.collection('usuarios').document(currentUser.uid);
    DocumentSnapshot userData = await usuario.get();

    var query = await db.collection('turnos')
        .where('usuario', isEqualTo: usuario)
        .where('caja', isEqualTo: widget.caja.reference)
        .where("atendido", isEqualTo: false)
        .where("eliminado", isEqualTo: false)
        .getDocuments();
    if(query.documents.length == 0){
      print("llega hasta ac");
      DateTime day = DateTime(date.year, date.month, date.day);

      var data = {
        "caja": widget.caja.reference,
        "usuario": usuario,
        "atendido": false,
        "fecha_atencion": Timestamp.fromDate(day),
        "hora_atencion": valueSelected,
        "turno":0,
        "reservado":true,
        "nombre": userData.data["nombre"],
        "apellido": userData.data["apellido"],
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

  void loadHoras()  async {
    DateTime today = DateTime(date.year, date.month, date.day);

    var query = await db
        .collection('turnos')
        .where('caja', isEqualTo: widget.caja.reference)
        .where('fecha_atencion', isEqualTo: Timestamp.fromDate(today))
        .where('reservado', isEqualTo: true)
        .where("eliminado", isEqualTo: false)
        .getDocuments();
    var horas = [
      '7:00',
      '7:30',
      '8:00',
      '8:30',
      '9:00',
      '9:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '14:00',
      '14:30',
      '15:00',
      '15:30',
      '16:00',
      '16:30',
      '17:00',
      '17:30'
    ];
    if(query != null){
      for(DocumentSnapshot document in query.documents){
        horas.removeWhere((element) => element == document["hora_atencion"]);
      }
    }

    setState(() {
      _horas= horas;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Reservar Turno",
            style: new TextStyle(fontFamily: 'FugazOne', fontSize: 23),
          ),
        ),
        body: new ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
                        setState(() {
                          this.date = date;
                          this._horas = [];
                          this.valueSelected = null;
                          _date = '${date.year} - ${date.month} - ${date.day}';
                        });
                        loadHoras();
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      " $_date",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          date == null ? Container():Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.watch, size: 18.0, color: Colors.teal),
                    SizedBox(
                      width: 5,
                    ),
                    DropdownButton<String>(
                      elevation: 4,
                      items: _horas.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Center(
                              child: Text(
                                dropDownStringItem,
                                textAlign: TextAlign.end,
                              ),
                            ));
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          valueSelected = newValueSelected;
                        });
                      },
                      hint: Text("Seleccione una hora",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0)),
                      isExpanded: false,
                      value: valueSelected,
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: FlatButton(
              child: Container(
                child: FittedBox(
                  alignment: Alignment(30, 30),
                  child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      children: <Widget>[
                        Container(
                            width: 250,
                            child: new FlatButton(
                              child: new Text(
                                "Reservar turno",
                                style: new TextStyle(
                                    fontSize: 45.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Questrial'),
                              ),
                              onPressed: crearTurno,
                            )),
                        Container(
                          width: 300,
                          height: 250,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.cover,
                              alignment: Alignment.topRight,
                              image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2017/06/10/06/39/calender-2389150_960_720.png"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onPressed: crearTurno,
            ),
          ),
        ]));
  }
}
