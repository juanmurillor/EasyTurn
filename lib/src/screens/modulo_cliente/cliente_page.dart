import 'package:flutter/material.dart';
import '../login/auth.dart';

class ClientePage extends StatefulWidget {
  ClientePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;


  @override
    State<StatefulWidget> createState() => new _ClientePageState();
    }
class _ClientePageState extends State<ClientePage>{

  
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
        title: Text("Bienvenido Cliente"),
        actions: <Widget>[
            new FlatButton(
              child: new Text('Cerrar Sesion', style: new TextStyle(fontSize: 17.0, color: Colors.white),),
              onPressed: _signOut
            )
          ],
      ),
      body: Center(
      ),
    );
  }
}