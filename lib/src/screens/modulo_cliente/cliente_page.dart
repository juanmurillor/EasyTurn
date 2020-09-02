import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_turn/src/screens/Comun/FooterSlider.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/login/cambiar_contrasena.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_de_turnos/lista_turnos.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_enterate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_turn/src/screens/modulo_publicidad/menu_publicidad.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_secciones.dart';

import 'CalificacionApp.dart';



class ClientePage extends StatefulWidget {
  ClientePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut; 


  @override
    State<StatefulWidget> createState() => new _ClientePageState();
    }
class _ClientePageState extends State<ClientePage>{
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final db = Firestore.instance;

   static String emailUsu = "";
   static String Nombre = "";
   static String Apellido = "";
   static String urlImagen;
   var listaUsuarios = [];


  
    Future<String>  userEmail() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        emailUsu = user.email;
        urlImagen = user.photoUrl;
      });
      //print(emailUsu);
      }

    void usuario() async{
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      db.collection('usuarios').document(user.uid).get().then((snapshot) {
        setState(() {
          Nombre = snapshot.data['nombre'];
          Apellido = snapshot.data['apellido'];
        });

      });
    }


  @override
  void initState(){
    super.initState();
    firemess();
    userEmail();
    usuario();
  }

  void firemess()async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    _firebaseMessaging.subscribeToTopic(user.uid);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        DocumentSnapshot doc = await db.document(message["data"]["caja"]).get();
        print("docggeted" + doc.data.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListaTurnosPage(caja: doc, ready: message["data"]["ready"] == 'true',)),
        );
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        DocumentSnapshot doc = await db.document(message["data"]["caja"]).get();
        print("docggeted" + doc.data.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListaTurnosPage(caja: doc, ready: message["data"]["ready"] == 'true',)),
        );
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true)
    );
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

 void moveToMenuPublicidadPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuEnteratePage()),
              );
  }
  void moveToMenuSeccionesPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuSeccionesPage(prevloaded: false,)),
              );
  }
  void moveToCalificarServicioPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalificacionAppPage()),
              );
  }

  void moveToCambiarContasenaPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CambiarContasenaPage()),
    );
  }
void _signOut() async {

  try{
    await widget.auth.signOut();
    widget.onSignedOut();

  }catch (e){
    print (e);

  }
}
 

  
  Widget build(BuildContext context) {
    return Scaffold(

      
     
      appBar: AppBar(
        title: Text("USB Turnos App",style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 30,
          color: Colors.orangeAccent
        ),),
        
            
          
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(Nombre+" "+Apellido, style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'Questrial'
              ),),
              accountEmail: new Text(emailUsu,style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                 fontFamily: 'Questrial'
              ),),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(urlImagen == null || urlImagen == ""? "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png" : urlImagen),
                )
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage("https://cdn.pixabay.com/photo/2016/06/25/12/52/laptop-1478822_960_720.jpg")
                )
              ),
            ),
            new ListTile(
              title: new Text("Cambiar contraseña",style: new TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'Questrial', fontWeight: FontWeight.w500),),
              onTap: moveToCambiarContasenaPage,
            ),
            new ListTile(
              title: new Text("Cerrar Sesion",style: new TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'Questrial', fontWeight: FontWeight.w500),),
              trailing: new Icon(Icons.close),
              onTap: _signOut,
            ), 

            new Divider(),
          ],
        )
      ),
      body:
        new  ListView(
          padding: EdgeInsets.only(bottom: 100),
          scrollDirection: Axis.vertical,
          children: <Widget>[
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
                            width: 258,
                            child: new FlatButton(
                              child: new Text(
                                "Gestiona tu turno",
                                style: new TextStyle(fontSize: 40.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Questrial'
                                ),
                              ),
                              onPressed: moveToMenuSeccionesPage,
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
                                image: NetworkImage("https://www.claro.com.co/portal/co/recursos_contenido/1585613186670.png"),
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                onPressed: moveToMenuSeccionesPage,
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
                            width: 258,
                            child: new FlatButton(
                              child: new Text(
                                "Enterate sobre nosotros",
                                style: new TextStyle(fontSize: 40.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Questrial'
                                ),
                              ),
                              onPressed: moveToMenuPublicidadPage,
                            ),
                          ),
                          Container(
                            width: 300,
                            height: 250,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                image: NetworkImage("https://elclavo.com/wp-content/uploads/2015/06/Universidaddesan-buenaventura20130927.jpg"),
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
                                  "Califica nuestro servicio",
                                  style: new TextStyle(fontSize: 40.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Questrial'
                                  ),
                                ),
                                onPressed: moveToCalificarServicioPage,
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
                                image: NetworkImage("https://cdn.pixabay.com/photo/2018/03/19/09/25/feedback-3239454_960_720.jpg"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                onPressed: moveToCalificarServicioPage,
              ),
            ),
          ],


        ),
      bottomSheet: FooterSlider(),

    );
  }
}
