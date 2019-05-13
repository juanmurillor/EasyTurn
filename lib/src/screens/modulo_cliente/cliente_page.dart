import 'package:easy_turn/src/screens/login/auth.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_admin/menu_secc_administrativa.dart';
import 'package:easy_turn/src/screens/modulo_cliente/seccion_restaurantes/menu_restaurantes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class ClientePage extends StatefulWidget {
  ClientePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut; 


  @override
    State<StatefulWidget> createState() => new _ClientePageState();
    }
class _ClientePageState extends State<ClientePage>{
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  
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

 void moveToMenuRestaurantesPage(){
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuRestaurantesPage()),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EasyTurn"),
        
          
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Arley Agudelo", style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),),
              accountEmail: new Text("arleyyap@gmail.com",style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400
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
              title: new Text("Cerrar Sesion",style: new TextStyle(fontSize: 15.0, color: Colors.black),),
              trailing: new Icon(Icons.close),
              onTap: _signOut,
            ), 
            new Divider(),
            new ListTile(
              title: new Text("Terminos y Condiciones",style: new TextStyle(fontSize: 15.0, color: Colors.black),),
              trailing: new Icon(Icons.info),
            ),
            new ListTile(
              title: new Text("Acerca de EasyTurn",style: new TextStyle(fontSize: 15.0, color: Colors.black),),
              trailing: new Icon(Icons.help),
            ),
         
          ],
        )
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
                        "Restaurantes",
                      style: new TextStyle(fontSize: 35.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic
                      ),
                      ),
                      onPressed: moveToMenuRestaurantesPage,
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2016/08/23/23/11/egg-1615790_960_720.jpg"),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            ),
            onPressed: moveToMenuRestaurantesPage,
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
                        "Seccion Administrativa",
                      style: new TextStyle(fontSize: 34.0, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic
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
                          image: NetworkImage("https://cdn.pixabay.com/photo/2018/02/14/10/28/business-3152586_960_720.jpg"),
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
          ],
      
          
      ),
    );
  }
}