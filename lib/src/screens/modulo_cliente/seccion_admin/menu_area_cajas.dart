import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuAreaCajasPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuAreaCajasPage();


   

}
class _MenuAreaCajasPage extends State<MenuAreaCajasPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Area de Cajas"),
      ),
      body: 
      new TurnosCajaList(),
      
        
      );
    
  } 
}
class TurnosCajaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('TurnosCaja').orderBy("Turno",).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text('Turno: ${document['Turno']}'),
                  subtitle: new Text('Nombre: ${document['Nombre']}'),
                );
              }).toList(),
            );
        }
      },
    );
  }
}