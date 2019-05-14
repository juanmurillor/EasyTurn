import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class MenuAreaFinancieraPage extends StatefulWidget {
 MenuAreaFinancieraPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() => new _MenuAreaFinancieraPage();
}

class _MenuAreaFinancieraPage extends State<MenuAreaFinancieraPage> {


  
  final db = Firestore.instance;

    String id;



void crearTurno() async{
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String Token;
      FirebaseUser user =await FirebaseAuth.instance.currentUser();

      _firebaseMessaging.getToken().then((token){
      print('Este es el token en menu_area_financiera');
      Token = token;
      print(token);
    });

      print("signed in" + user.email);
      
      var resultado = [];
      Buscar().buscarusuario(user.email).then((QuerySnapshot docs) async {
        String Nombre;
        String Apellido;
        
        for (int i = 0; i < docs.documents.length; i++) {
              resultado.add(docs.documents[i].data.values.toList());
              print(docs.documents[i].data);
            }
            print("este es el nombre "+resultado[0][3]);
            Nombre = resultado[0][3];
            Apellido = resultado[0][0];
            

        DocumentReference ref = await db.collection('TurnosFinanciero').add({
            'Nombre': '$Nombre',
            'Apellido': '$Apellido',
            'Turno': 2
            
           
          });
          setState(() => id = ref.documentID);
          print(ref.documentID);
        DocumentReference ref2 = await db.collection('TurnosFinanciero_Tokens').add({
            'token': '$Token'
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
        title: Text("Area Financiera"),
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
          .collection('TurnosFinanciero')
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
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.right),
                            new Text('Apellido: ${document['Apellido']}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.right),
                            new Text('Nombre: ${document['Nombre']}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
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
