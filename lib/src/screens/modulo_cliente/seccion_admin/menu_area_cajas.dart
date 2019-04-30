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
      body: new  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                        "Area Academica",
                      style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic
                      ),
                      ),
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/10/12/19/54/homework-1735644_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
          ), 
          Padding(
             padding: const EdgeInsets.all(16.0),
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
                        "Area Financiera",
                      style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic
                      ),
                      ),
                      
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight,
                          image: NetworkImage("https://cdn.pixabay.com/photo/2018/02/15/09/48/paperwork-3154814_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            ),
             Padding(
             padding: const EdgeInsets.all(16.0),
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
                        "Area de Cajas",
                      style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic
                      ),
                      ),
                      
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 250,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight,
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/12/06/04/26/cash-register-1885558_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            )
          ],
      
          
      ),
    );
  } 
}
class TurnosCajaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('TurnosCaja').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['Turno']),
                  subtitle: new Text(document['Nombre']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}