import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_academic.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/turnos_academicos/calificacion_turnoReg_academico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';


class PedirTurnoAcademicoPage extends StatefulWidget{

  PedirTurnoAcademicoPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override

  
    State<StatefulWidget> createState () => new _PedirTurnoAcademicoPage();
   

}
class _PedirTurnoAcademicoPage extends State<PedirTurnoAcademicoPage>{

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
          var telefono;
          String email;
          email = user.email;

          for (int i = 0; i < docs.documents.length; i++) {
            resultado.add(docs.documents[i].data.values.toList());
            print(docs.documents[i].data);
          }
          print("este es el nombre " + resultado[0][3]);
          Nombre = resultado[0][4];
          Apellido = resultado[0][2];
          telefono = resultado[0][3];
          DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
          String fechaHora = dateFormat.format(DateTime.now());



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
       
              

          var document =await Firestore.instance.document('TurnosAcademico/--turnos--');
          DocumentSnapshot snapshot = await db
              .collection('TurnosAcademico')
              .document('--turnos--')
              .get();
          print(snapshot.data['TurnoIncremental']);

          int Turno = snapshot.data['TurnoIncremental'];

          var refe = db.collection('TurnosAcademico').document('$lol');
          var refeEstadistica = db.collection('TurnosAcademicoEstadistica').document('$lol');

          print(lol);
          print("esta es la fecha " + fechaHora);


          batch.setData(
              refe,
              {
                'Nombre': '$Nombre',
                'Apellido': '$Apellido',
                'email': '$email',
                'Turno': Turno,
                'telefono': telefono,
                'FechaHora': '$fechaHora',
              },
              merge: true);

            batch.setData(
              refeEstadistica,
              {
                'Nombre': '$Nombre',
                'Apellido': '$Apellido',
                'email': '$email',
                'Turno': Turno,
                'FechaHora': '$fechaHora',
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

         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CaliTurnoRegAcademicoPage()),
              );

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
   



  


  @override

  Widget image_carousel = new Container(
        height: 140.0,
        child: CarouselSlider(
          height: 140.0,
          autoPlay: true,

          items: [
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannerpagina-virtual_0.jpg?itok=nQ63tL_p',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/inscripciones_2020-2-01_0.jpg?itok=tJi6mRZ4'
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(i, fit: BoxFit.fill),
                        onTap  : () async
                          {
                            const url = 'https://www.usbcali.edu.co/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          
                        },
                        )
                        );
                        
              },
            );
          }).toList(),
        ));

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
            child: image_carousel,
          ) 
        
              ]),
              ),
          ],
        )
     ),     
    );
  }

    
}
