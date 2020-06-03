import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_financiera.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_academicos.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_ing_electronica.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_ing_multimedia.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_ing_agroindustrial.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_ing_industrial.dart';


import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_caja.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_financiera.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

class MenuSeccAdministrativaPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuSeccAdministrativaPage();


   

}
class _MenuSeccAdministrativaPage extends State<MenuSeccAdministrativaPage>{

  void moveToMenuTurnosFinancieraPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuTurnosFinancieraPage()),
              );
  }
  void moveToMenuTurnosCajaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuTurnosCajaPage()),
              );
  }
  void moveToMenuTurnosAcademicosPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuTurnosAcademicosPage()),
              );
  }

   void moveToMenuIngMultimediaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuIngMultimediaPage()),
              );
  }
   void moveToMenuIngIndustrialPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuIngIndustrialPage()),
              );
  }
   void moveToMenuIngElectronicaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuIngElectronicaPage()),
              );
  }
   void moveToMenuIngAgroPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuIngAgroPage()),
              );
  }



  @override

  /*Widget image_carousel = new Container(
        height: 100.0,
        child: CarouselSlider(
           height: 100.0,
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
*/


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programas Academicos",style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 23
        ),),
      ),
      body: new  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
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
                        "Ingenieria de Sistemas",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2017/03/13/23/31/icon-2141485_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuTurnosAcademicosPage,
            ),
          ),
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
                        "Ingenieria Multimedia",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2015/12/03/01/27/play-1073616_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuIngMultimediaPage,
            ),
          ), 
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
                        "Ingenieria Industrial",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/09/16/19/15/gear-1674891_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuIngIndustrialPage,
            ),
          ), 
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
                      width: 260,
                      child: new FlatButton(
                      child: new Text(
                        "Ingenieria Agroindustrial",
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
                          image: NetworkImage("https://cdn0.iconfinder.com/data/icons/ecology-and-nature-2/64/_Farm-512.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuIngAgroPage,
            ),
          ), 
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
                        "Ingenieria electronica",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/10/27/03/44/processor-1773308_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuIngElectronicaPage,
            ),
          ),  
          /*Padding(
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
                        "Turnos Area Financiera",
                       style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                       fontFamily: 'Questrial'
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
            onPressed: moveToMenuTurnosFinancieraPage,
             ),
            ),
             Padding(
             padding: const EdgeInsets.all(16.0),
             child: new FlatButton(
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
                        "Turnos Area de Cajas",
                      style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                       fontFamily: 'Questrial'
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
            onPressed: moveToMenuTurnosCajaPage,
             ),
            )*/
          ],
      
          
      ),
    );
  }

    
}
