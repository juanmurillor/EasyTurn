import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/pedir_turno_academico.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



class CaliTurnoRegAcademicoPage extends StatefulWidget {
  CaliTurnoRegAcademicoPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _CaliTurnoRegAcademicoPage createState() => _CaliTurnoRegAcademicoPage();
}

class _CaliTurnoRegAcademicoPage extends State<CaliTurnoRegAcademicoPage> {
  var myFeedbackText = "ES BUENO";
  var sliderValue = 2.5;
  IconData myFeedback = FontAwesomeIcons.smile;
  Color myFeedbackColor = Colors.yellow;

   final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;

  String id;

  void crearCalificacion() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String emailUsu = user.email;
    print(emailUsu);

    getTurno(String emailsito) {
      return db
          .collection('CalificacionTurnoAcademico')
          .where('email', isEqualTo: emailUsu)
          .getDocuments();
    }

    getTurno(emailUsu).then((QuerySnapshot docs) {
      
        FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
        String Token;


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
          Nombre = resultado[0][4];
          Apellido = resultado[0][2];
          DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
          String fechaHora = dateFormat.format(DateTime.now());



          var batch = db.batch();
         /// var increment = FieldValue.increment(1);
          var rng = new Random();
          var lol = new List.generate(12, (_) => rng.nextInt(100));
         

          var refe = db.collection('CalificacionTurnoAcademico').document('$lol');
          print(lol);
          print("esta es la fecha " + fechaHora);


          batch.setData(
              refe,
              {
                'Nombre': '$Nombre',
                'Apellido': '$Apellido',
                'email': '$email',
                'Calificacion': sliderValue, 
                'FechaHora': '$fechaHora',
                
              },
              merge: true);
          batch.commit();


              _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Gracias por tu calificacion',
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

      
    });
    
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
        child: Column(
          children: <Widget>[
            Container(child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(child: Text("Es muy importante para nosotros conocer la opinion de nuestros usuarios, Califica como te parecio nuestro servicio",
                style: TextStyle(color: Colors.green[500], fontSize: 22.0,fontWeight:FontWeight.bold, fontFamily: 'Questrial'),textAlign: TextAlign.center,)),
            ),),
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
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Text(myFeedbackText,
                            style: TextStyle(color: Colors.black, fontSize: 22.0),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Icon(
                            myFeedback, color: myFeedbackColor, size: 100.0,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Slider(
                            min: 0,
                            max: 5,
                            divisions: 4,
                            value: sliderValue,
                            activeColor: Color(0xffe05f2c),
                            inactiveColor: Colors.blueGrey,
                            onChanged: (newValue) {
                              setState(() {
                                sliderValue = newValue;
                                if (sliderValue >= 0.0 && sliderValue <= 1.0) {
                                  myFeedback = FontAwesomeIcons.sadTear;
                                  myFeedbackColor = Colors.red;
                                  myFeedbackText = "PODRIA MEJORAR BASTANTE";
                                }
                                if (sliderValue >= 2.1 && sliderValue <= 3.0) {
                                  myFeedback = FontAwesomeIcons.smile;
                                  myFeedbackColor = Colors.yellow;
                                  myFeedbackText = "ES BUENO";
                                }
                                if (sliderValue >= 3.1 && sliderValue <= 4.0) {
                                  myFeedback = FontAwesomeIcons.laugh;
                                  myFeedbackColor = Colors.green;
                                  myFeedbackText = "ES EXELENTE";
                                }
                               
                              });
                            },
                          ),),
                        ),

                        Padding( 
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Deja un comentario sobre el servicio",
                                  hintText: "Comentario",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0)
                                  )

                                ),
                              ),
                            ),
                          ),
                        ),
                       
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              shape:RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              color: Color(0xffe05f2c),
                              child: Text('Submit',
                                style: TextStyle(color: Color(0xffffffff),fontFamily: 'Questrial'),),
                              onPressed: crearCalificacion 
                            ),
                          )),
                        ),
                      ],)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}