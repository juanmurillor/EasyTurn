import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_cajas.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_area_financiera.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_academicos.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_secc_administrativa.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_facultades/menu_programas_ingenieria.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_de_turnos/menu_turnos_caja.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_turn/notifier/profesor_notifier.dart';
import 'package:provider/provider.dart';



import 'package:flutter/material.dart';

class MenuSeccionesPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuSeccionesPage();


   

}
class _MenuSeccionesPage extends State<MenuSeccionesPage>{

  void moveToMenuSeccAdministrativaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuSeccAdministrativaPage()),
              );
  }
  void moveToMenuFacultadIngPage(){

   
    Navigator.push(
                  
                context,
                MaterialPageRoute(builder: (context) => MenuProgramasIngPage()),
              );
  }
  


  @override

  Widget image_carousel = new Container(
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



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Secciones",style: new TextStyle(
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
                        "Registro Academico",
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/10/12/19/54/homework-1735644_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuSeccAdministrativaPage,
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
                        "Facultad de ingenieria",
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
            onPressed: moveToMenuFacultadIngPage,
             ),
            ),
             
          ],
      
          
      ),
      bottomSheet: image_carousel,
    );
  }

    
}
