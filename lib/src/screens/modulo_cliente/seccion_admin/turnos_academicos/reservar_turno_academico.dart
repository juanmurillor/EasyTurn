import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_academic.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_financiera.dart';
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



class ReservarTurnoTurnoAcademicoPage extends StatefulWidget{

  ReservarTurnoTurnoAcademicoPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override

  
    State<StatefulWidget> createState () => new _ReservarTurnoTurnoAcademicoPage();
   

}
class _ReservarTurnoTurnoAcademicoPage extends State<ReservarTurnoTurnoAcademicoPage>{

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;

  String id;

  String _date = "Selecciona una fecha";
  String _time = "Selecciona Una Hora";
  String valueSelected;
  var _horas = ['7:00','7:30',
  '8:00','8:30',
  '9:00','9:30',
  '10:00','10:30',
  '11:00','11:30',
  '14:00','14:30',
  '15:00','15:30',
  '16:00','16:30',
  '17:00','17:30'];


  void crearTurno() async {
    if(_date == "Selecciona Una Fecha" || valueSelected == null){
       _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Por favor escoje una fecha y hora para reservar el turno',
            style: new TextStyle(color: Colors.white,
            fontFamily: 'Questrial',
              fontSize: 20,
              fontWeight: FontWeight.w600),
          ),
          backgroundColor: Color(0xFFFF0000),
        ));
    }else{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String emailUsu = user.email;
    print(emailUsu);

    getTurno(String emailsito) {
      return db
          .collection('TurnosReservadosAcademico')
          .where('email', isEqualTo: emailUsu)
          .getDocuments();
    }

    getTurno(emailUsu).then((QuerySnapshot docs) {
      if (docs.documents.isEmpty) {
        FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
        String Token;

        _firebaseMessaging.getToken().then((token) {
          print('Este es el token en menu_area_academica');
          Token = token;
          print(token);
        });

        print("signed in" + user.email);

        var resultado = [];
        Buscar().buscarusuario(user.email).then((QuerySnapshot docs) async {
          String Nombre;
          String Apellido;
          String email;
          email = user.email;

          for (int i = 0; i < docs.documents.length; i++) {
            resultado.add(docs.documents[i].data.values.toList());
            print(docs.documents[i].data);
          }
          print("este es el nombre " + resultado[0][3]);
          Nombre = resultado[0][3];
          Apellido = resultado[0][1];

          DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
          String fechaHora = dateFormat.format(DateTime.now());



          var batch = db.batch();
          var increment = FieldValue.increment(1);
          var rng = new Random();
          var lol = new List.generate(12, (_) => rng.nextInt(100));

          var refe2 = db.collection('TurnosReservadosAcademico').document('--turnos--');
          batch.setData(
              refe2,
              {
                'TurnoIncremental': increment,
              },
              merge: true);

          var document =
              await Firestore.instance.document('TurnosReservadosAcademico/--turnos--');
          DocumentSnapshot snapshot = await db
              .collection('TurnosReservadosAcademico')
              .document('--turnos--')
              .get();
          print(snapshot.data['TurnoIncremental']);

          int Turno = snapshot.data['TurnoIncremental'];

          var refe = db.collection('TurnosReservadosAcademico').document('$lol');
          print(lol);
          ///print("esta es la fecha " + fechaHora);


          batch.setData(
              refe,
              {
                'Nombre': '$Nombre',
                'Apellido': '$Apellido',
                'email': '$email',
                'Turno': Turno,
                'Fecha': '$_date',
                'Hora': '$valueSelected',

              },
              merge: true);
          batch.commit();

          /*DocumentReference ref = await db.collection('TurnosAcademico').add({
            'Nombre': '$Nombre',
            'Apellido': '$Apellido',
            'Turno': 1, 


            
           
          });
                      
        
      
          setState(() => id = ref.documentID);
          print(ref.documentID);*/
          DocumentReference ref2 = await db
              .collection('TurnosAcademico_Tokens')
              .add({'token': '$Token', 'email': '$email'});
          setState(() => id = ref2.documentID);
          print(ref2.documentID);

           _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Turno creado exitosamente, Turno #: $Turno',
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
      } else {
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
    });

    //var data = db.collection('TurnosAcademico').where('email', isEqualTo: emailUsu ).snapshots();

    /*DocumentReference ref = await db.collection('TurnoCaja').add({
            'Nombre': '$_nombre',
            'apellido': '$_apellido',
           
          });
          setState(() => id = ref.documentID);
          print(ref.documentID);*/
  }
  }

 

  

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Reservar Turno Area Academica",style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 23
        ),),
      ),
      body: new ListView (
      scrollDirection: Axis.vertical,
        children: <Widget>[
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
                    print('confirm $date');
                    _date = '${date.year} - ${date.month} - ${date.day}';
                    setState(() {});
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
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.watch,
              size: 18.0,
              color: Colors.teal),
              SizedBox(width: 5,),
              DropdownButton<String>(
                elevation: 4,
                items: _horas.map((String dropDownStringItem){
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Center(
                      child:  Text(dropDownStringItem, textAlign: TextAlign.end,),
                    )
                   
                  );
                }).toList(),
                onChanged: (String newValueSelected){
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
        )
      ),
                    SizedBox(height: 30,),

       Padding(
            padding: const EdgeInsets.all(1.0),
            child: FlatButton(
            child: Container(

              child: FittedBox(
                alignment: Alignment(30, 30),

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
                        "Reservar turno",
                     style: new TextStyle(fontSize: 45.0, 
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2017/06/10/06/39/calender-2389150_960_720.png"),
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
        ]
      )
    );
  }

    
}
