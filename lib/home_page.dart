import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget{

  

  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

@override
  State<StatefulWidget> createState() => new _HomePageState();

}
  class _HomePageState extends State<HomePage> {


  final db = Firestore.instance;
  String id;



void readData() async{
  DocumentSnapshot snapshot = await db.collection('usuarios').document(id).get();
  print((snapshot.data[
        'nombre']));
}


void _signOut() async {

  try{
    await widget.auth.signOut();
    widget.onSignedOut();

  }catch (e){
    print (e);

  }
}

 Card buildItem(DocumentSnapshot doc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'nombre: ${doc.data['nombre']}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'apellido: ${doc.data['apellido']}',
              style: TextStyle(fontSize: 20),
            ),
           
              ],
            )
          
        ),
      
    );
  }
    
  

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Bienvenido'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cerrar Sesion', style: new TextStyle(fontSize: 17.0, color: Colors.white),),
              onPressed: _signOut
            )
          ],
        ),
        
        body: new ListView(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
            stream: db.collection('usuarios').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox();
              }
            }
            )
          ] 
          )  
        );
    }
}
