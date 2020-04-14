import 'package:flutter/material.dart';
import 'src/screens/login/auth.dart';
import 'src/screens/login/login_page.dart';
import 'src/screens/modulo_cliente/cliente_page.dart';
import 'src/screens/modulo_restaurante/restaurante_page.dart';

class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;

  @override
    State<StatefulWidget> createState() => new _RootPageState();
   
}

enum AuthStatus {
  notSignedIn,
  signedInAsCliente

}

class _RootPageState extends State<RootPage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
    void initState() {
      super.initState();
      widget.auth.currentUser().then((userId){
        setState(() {
                  
                  authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedInAsCliente;
                 


                });

      });
    }

    
     
     void _signedInAsCliente(){
      setState(() {
              authStatus = AuthStatus.signedInAsCliente;
              
            });

    }




     void _signedOut(){
      setState(() {
              authStatus = AuthStatus.notSignedIn;
            });

    }



  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
          return new LoginPage(
            auth: widget.auth,
         
            onSignedInAsCliente: _signedInAsCliente,

          );


      case AuthStatus.signedInAsCliente:
      return new ClientePage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );





    }

  }

}