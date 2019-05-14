import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math';


class MenuAreaAcademicaPage extends StatefulWidget {
  MenuAreaAcademicaPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => new _MenuAreaAcademicaPage();
}

class _MenuAreaAcademicaPage extends State<MenuAreaAcademicaPage> {


  
  final db = Firestore.instance;

    String id;



void crearTurno() async{
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String Token;
      FirebaseUser user =await FirebaseAuth.instance.currentUser();

      _firebaseMessaging.getToken().then((token){
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
        email=user.email;
        
        for (int i = 0; i < docs.documents.length; i++) {
              resultado.add(docs.documents[i].data.values.toList());
              print(docs.documents[i].data);
            }
            print("este es el nombre "+resultado[0][3]);
            Nombre = resultado[0][3];
            Apellido = resultado[0][0];
            
        var batch = db.batch();
        var increment = FieldValue.increment(1);
        var rng = new Random();
        var lol = new List.generate(12, (_) => rng.nextInt(100));

        var refe = db.collection('TurnosAcademico').document('$lol');
        print(lol);

        batch.setData(refe, {
          'Nombre':'$Nombre',
          'Apellido': '$Apellido',
          'email':  '$email',
          'Turno': increment,


        }, merge: true);
        batch.commit();
        
        
        /*DocumentReference ref = await db.collection('TurnosAcademico').add({
            'Nombre': '$Nombre',
            'Apellido': '$Apellido',
            'Turno': 1, 


            
           
          });
                      
        
      
          setState(() => id = ref.documentID);
          print(ref.documentID);*/
        DocumentReference ref2 = await db.collection('TurnosAcademico_Tokens').add({
            'token': '$Token',
            'email':  '$email'

          });
          setState(() => id = ref2.documentID);
          print(ref2.documentID);

      });





  /*DocumentReference ref = await db.collection('TurnoCaja').add({
            'Nombre': '$_nombre',
            'apellido': '$_apellido',
           
          });
          setState(() => id = ref.documentID);
          print(ref.documentID);*/

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Area Academica"),
      ),
      body: TurnosCajaList(),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_circle),
        label: Text("Pedir Turno"),
        onPressed: crearTurno,
        isExtended: true,
      ),
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
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.right),
                          
                            new Text('Nombre: ${document['Nombre']}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.right),
                            new Text('Apellido: ${document['Apellido']}',
                                style: TextStyle(
                                    fontSize: 20.0,
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
