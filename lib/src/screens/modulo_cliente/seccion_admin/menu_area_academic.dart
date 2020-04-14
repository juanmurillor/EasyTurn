import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuAreaAcademicaPage extends StatefulWidget {
  MenuAreaAcademicaPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => new _MenuAreaAcademicaPage();
}

class _MenuAreaAcademicaPage extends State<MenuAreaAcademicaPage> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final db = Firestore.instance;

  String id;

  void crearTurno() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String emailUsu = user.email;
    print(emailUsu);

    getTurno(String emailsito) {
      return db
          .collection('TurnosAcademico')
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
          Nombre = resultado[0][4];
          Apellido = resultado[0][2];

          var batch = db.batch();
          var increment = FieldValue.increment(1);
          var rng = new Random();
          var lol = new List.generate(12, (_) => rng.nextInt(100));

          var refe2 = db.collection('TurnosAcademico').document('--turnos--');
          batch.setData(
              refe2,
              {
                'TurnoIncremental': increment,
              },
              merge: true);

          var document =
              await Firestore.instance.document('TurnosAcademico/--turnos--');
          DocumentSnapshot snapshot = await db
              .collection('TurnosAcademico')
              .document('--turnos--')
              .get();
          print(snapshot.data['TurnoIncremental']);

          int Turno = snapshot.data['TurnoIncremental'];

          var refe = db.collection('TurnosAcademico').document('$lol');
          print(lol);

          batch.setData(
              refe,
              {
                'Nombre': '$Nombre',
                'Apellido': '$Apellido',
                'email': '$email',
                'Turno': Turno,
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
              fontSize: 15,
              fontWeight: FontWeight.w600
              ),
          ),
          backgroundColor: Color(0xFF01DF3A),
        ));

        });
      } else {
        _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Ya creaste un turno, porfavor espera ser atendido',
            style: new TextStyle(color: Colors.white,
            fontFamily: 'Questrial',
              fontSize: 15,
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

  @override
  Widget image_carousel = new Container(
        height: 200.0,
        child: CarouselSlider(
          height: 300.0,
          autoPlay: true,

          items: [
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannermicrositio50.jpg?itok=D-0pOzWQ',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannerppal_mesa_de_trabajo_1_0.jpg?itok=uDic4wao',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannersolicitudcredito735x250-01.jpg?itok=nVHf_ylY',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannerinscripciones2020-1.jpg?itok=gn9m88n0'
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(i, fit: BoxFit.fill),
                        onTap: () {
                          launchURL() async {
                            const url = 'https://www.usbcali.edu.co/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                        }));
              },
            );
          }).toList(),
        ));


  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Area Academica",style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 23
        ),),
      ),
      body:             
      new TurnosCajaList(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_circle),
        label: Text("Pedir Turno",style: new TextStyle(
          fontFamily: 'Questrial',
          fontSize: 15,
          fontWeight: FontWeight.w600
        ),),
        onPressed: crearTurno,
        isExtended: true,
      ),
      bottomSheet: image_carousel,
    );
  }
}

class TurnosCajaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('TurnosAcademico')
          .orderBy(
            "Turno",
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text('Turno: ${document['Turno']}',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.right),
                          ]),
                          new Column(
                            children: <Widget>[
                              new Text("     ")
                            ],
                          ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text('Nombre: ${document['Nombre']}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                            new Text('Apellido: ${document['Apellido']}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
