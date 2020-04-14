import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_secc_administrativa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:easy_turn/src/screens/login/buscar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_turn/src/screens/modulo_publicidad/menu_publicidad.dart';




class ClientePage extends StatefulWidget {
  ClientePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut; 


  @override
    State<StatefulWidget> createState() => new _ClientePageState();
    }
class _ClientePageState extends State<ClientePage>{
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

   static String emailUsu = "";
   static String Nombre = "";
   static String Apellido = "";
   var listaUsuarios = [];

  
    Future<String>  userEmail() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      emailUsu = user.email;
      //print(emailUsu);
      }

    void usuario(){
    

    Buscar().buscarusuario(emailUsu).then((QuerySnapshot docs2) async {
      for (int i = 0; i < docs2.documents.length; i++) {
        listaUsuarios.add(docs2.documents[i].data.values.toList());
        //print(docs.documents[i].data);
      }
      Nombre = listaUsuarios[0][4];
      Apellido = listaUsuarios[0][2];
    });
    }
  
  @override
  void initState(){
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('Hola');
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('Hola2');
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('Hola3');
        print('on launch $message');
      },
    );
    _firebaseMessaging.getToken().then((token){
      print('Este es el token');
      print(token);
    });
  }

 void moveToMenuPublicidadPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPublicidadPage()),
              );
  }
  void moveToMenuSeccAdministrativaPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuSeccAdministrativaPage()),
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
 

  

  @override
  Widget image_carousel = new Container(
        height: 140.0,
        child: CarouselSlider(
          height: 140.0,
          autoPlay: true,

          items: [
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannerpagina-virtual_0.jpg?itok=nQ63tL_p',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/inscripciones_2020-2-01_0.jpg?itok=tJi6mRZ4',
            
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
    userEmail();
    usuario();

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
                  backgroundImage: new NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png"),
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
              title: new Text("Cerrar Sesion",style: new TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'Questrial', fontWeight: FontWeight.w500),),
              trailing: new Icon(Icons.close),
              onTap: _signOut,
            ), 
            new Divider(),
           
          ],
        )
      ),
      body: new  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
         /* Padding(
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
                        "Ubicate en la USB",
                      style: new TextStyle(fontSize: 40.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Questrial'
                      ),
                      ),
                      onPressed: moveToMenuSeccAdministrativaPage,
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2013/07/13/14/05/location-162102_960_720.png"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            
            ),
          ), */
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
                      onPressed: moveToMenuSeccAdministrativaPage,
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
                          image: NetworkImage("http://www.farestaie.com/webcheckin/img/solicitar-turno.png"),
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
          ],
      
          
      ),
      bottomSheet: image_carousel,
      
    );
  }
}
