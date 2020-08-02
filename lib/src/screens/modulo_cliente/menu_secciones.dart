import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_turn/src/screens/Comun/FooterSlider.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_de_turnos/menu_turnos.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_profesores.dart';
import 'package:url_launcher/url_launcher.dart';



import 'package:flutter/material.dart';

class MenuSeccionesPage extends StatefulWidget{

  DocumentReference ref;
  MenuSeccionesPage({Key key, this.ref}):super(key:key);

  @override
    State<StatefulWidget> createState () => new _MenuSeccionesPage();

}
class _MenuSeccionesPage extends State<MenuSeccionesPage>{

  List options = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  void loadData() async {
    DocumentReference references = widget.ref;
    var db = Firestore.instance;
    var documents = references == null ? await db.collection('secciones').getDocuments() : await references.collection('subareas').getDocuments();
    setState(() {
      options = documents.documents;
    });
  }

  void openOption(DocumentSnapshot option){
    if(option.data["objeto"] == "subarea"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuSeccionesPage(ref: option.reference,)),
      );
    }else if(option.data["objeto"] == "turnos"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuTurnosPage(documentSnapshot: option,)),
      );
    }else if(option.data["objeto"] == "profesores"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuProfesoresPage(documentSnapshot: option,)),
      );
    }

  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Secciones",style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 23
        ),),
      ),
      body: new  ListView(
        padding: EdgeInsets.only(bottom: 100),
        scrollDirection: Axis.vertical,
        children: options.map((option) {
          return Padding(
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
                                StringUtils.capitalize(option.data["nombre"]),
                                style: new TextStyle(fontSize: 35.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Questrial'
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
                              image: NetworkImage((option.data["imagen"]),
                            ),
                          ),
                        )
                        )],
                    ),
                  ),
                ),
              ),
              onPressed: ()=>openOption(option),
            ),
          );
        }).toList()
      
          
      ),
      bottomSheet: FooterSlider(),
    );
  }

    
}
