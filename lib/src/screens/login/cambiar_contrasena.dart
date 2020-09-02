import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CambiarContasenaPage extends StatefulWidget {
  @override
  _CambiarContasenaPage createState() => _CambiarContasenaPage();
}

class _CambiarContasenaPage extends State<CambiarContasenaPage> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var antigua_contrasena, repetir_nueva_contrasena, nueva_contrasena;


  void _cambiarContrasena()async{
    if(_formKey.currentState.validate()){
      var user = await FirebaseAuth.instance.currentUser();
      var credential = EmailAuthProvider.getCredential(email: user.email, password: antigua_contrasena);
      user.reauthenticateWithCredential(credential).then((value){
        user.updatePassword(nueva_contrasena).then((value) {
          _scaffoldState.currentState.showSnackBar(new SnackBar(
            content: new Text(
              'Se ha actualizado tu contraseña',
              style: new TextStyle(color: Colors.black),
            ),
            backgroundColor: Color(0xFF64FF7F),
          ));
        });
      }).catchError((onError){
        _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            onError.message,
            style: new TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFC91301),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          "Cambiar contraseña",
          style: new TextStyle(fontFamily: 'FugazOne', fontSize: 23),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
          TextFormField(
            style: new TextStyle(
                fontFamily: 'Questrial'
            ),
            decoration: new InputDecoration(labelText: 'Antigua contraseña'),
            obscureText: true ,
            validator: (value){
              antigua_contrasena = value;
              return value.isEmpty ? 'Este campo no puede estar vacio' : null;
            },
            onSaved: (value) => antigua_contrasena = value,
          ),
          TextFormField(
            style: new TextStyle(
                fontFamily: 'Questrial'
            ),
            decoration: new InputDecoration(labelText: 'Nueva contraseña'),
            obscureText: true ,
            validator: (value){
              nueva_contrasena = value;
              return value.isEmpty ? 'Este campo no puede estar vacio' : (value.length < 6 ? 'La constraseña debe tener minimo 6 digitos':null);
            },
            onSaved: (value) => nueva_contrasena = value,
          ),
          TextFormField(
            style: new TextStyle(
                fontFamily: 'Questrial'
            ),
            decoration: new InputDecoration(labelText: 'Repetir nueva contraseña'),
            obscureText: true ,
            validator: (value){
              repetir_nueva_contrasena = value;
              return value.isEmpty ? 'Este campo no puede estar vacio' : ( nueva_contrasena != repetir_nueva_contrasena ? 'Las dos contraseñas no coinciden' :null);
            },
            onSaved: (value) => repetir_nueva_contrasena = value,
          ),
          new RaisedButton(
            child: new Text(
              'Cambiar contraseña',
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Questrial'
              ),
            ),
            color: Colors.blue,
            onPressed: _cambiarContrasena,
          ),
        ]),
      ),
    );
  }
}
