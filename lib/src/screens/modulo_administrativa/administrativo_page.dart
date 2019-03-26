import 'package:flutter/material.dart';
import '../login/auth.dart';

class AdministradorPage extends StatefulWidget {
  AdministradorPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;


  @override
    State<StatefulWidget> createState() => new _AdministradorPage();

}   
     
class _AdministradorPage extends  State<AdministradorPage>{

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
    return new Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido Administrativo"),
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


 
