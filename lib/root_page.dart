import 'package:flutter/material.dart';
import 'src/screens/login/auth.dart';
import 'src/screens/login/login_page.dart';
import 'src/screens/modulo_administrativa/administrativo_page.dart';
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
  signedInAsRestaurante,
  signedInAsAdministrativo,
  signedInAsCliente

}

class _RootPageState extends State<RootPage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
    void initState() {
      super.initState();
      widget.auth.currentUser().then((userId){
        setState(() {
                  authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedInAsAdministrativo;
                  authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedInAsCliente;
                  authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedInAsRestaurante;


                });

      });
    }

    void _signedInAsRestaurante(){
      setState(() {
              authStatus = AuthStatus.signedInAsRestaurante;
              
            });

    }
     void _signedInAsAdministrativo(){
      setState(() {
              authStatus = AuthStatus.signedInAsAdministrativo;
              
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
            onSignedInAsAdministrativo: _signedInAsAdministrativo, 
            onSignedInAsRestaurante: _signedInAsRestaurante,
            onSignedInAsCliente: _signedInAsCliente,

          );

      case AuthStatus.signedInAsAdministrativo:
      return new AdministradorPage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );

      case AuthStatus.signedInAsRestaurante:
      return new RestaurantePage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );

      case AuthStatus.signedInAsCliente:
      return new ClientePage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );





    }

  }

}