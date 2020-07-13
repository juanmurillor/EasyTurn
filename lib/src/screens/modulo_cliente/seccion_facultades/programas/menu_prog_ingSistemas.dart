import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_financiera.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_academicos.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_caja.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_financiera.dart';
import 'package:easy_turn/notifier/profesor_notifier.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_facultades/profesores/menu_profesores.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuIngSistemasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MenuIngSistemasPage();
}

class _MenuIngSistemasPage extends State<MenuIngSistemasPage> {
  void moveToMenuTurnosFinancieraPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuTurnosFinancieraPage()),
    );
  }

  void moveToMenuTurnosCajaPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuTurnosCajaPage()),
    );
  }

  void moveToMenuTurnosAcademicosPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuTurnosAcademicosPage()),
    );
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
                    onTap: () async {
                      const url = 'https://www.usbcali.edu.co/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ));
            },
          );
        }).toList(),
      ));

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Ingenieria de sistemas",
            style: new TextStyle(fontFamily: 'FugazOne', fontSize: 23),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("Profesores")
                    .where("Programa", isEqualTo: "Ingenieria de sistemas")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasError) return Text('Error');

                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final list = querySnapshot.data.documents;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                          width: 120,
                          fit: BoxFit.fitWidth,),
                          title: Text(list[index]['Nombre']+' '+list[index]['Apellido']),
                          subtitle: Text(list[index]['Programa']),
                          onTap: (){
                            DocumentSnapshot profesorList = list[index];
                            Navigator.push(
                              context,
                             MaterialPageRoute(builder: (context) => MenuProfesoresPage(list[index]))
                            );
                          },
                        );
                      },
                      itemCount: list.length,
                      separatorBuilder: (BuildContext context, int index ){
                        return Divider(
                          color:Colors.black,

                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
