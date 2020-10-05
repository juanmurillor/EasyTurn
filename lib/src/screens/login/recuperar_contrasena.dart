import 'dart:io';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecuperarContasenaPage extends StatefulWidget {
  @override
  _RecuperarContrasenaPage createState() => _RecuperarContrasenaPage();
}

class _RecuperarContrasenaPage extends State<RecuperarContasenaPage> {
  final GlobalKey<ScaffoldState> _scaffoldState =
  new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var email;


  void _recuperarContrasena()async{
    if(_formKey.currentState.validate()){
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            'Se ha enviado un enlace a tu correo',
            style: new TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFF64FF7F),
        ));
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
          "Recuperar contraseña",
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
                decoration: new InputDecoration(labelText: 'Correo electronico'),
                obscureText: true ,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  email = value;
                  return value.isEmpty ? 'Este campo no puede estar vacio' : null;
                },
                onSaved: (value) => email = value,
              ),
              new RaisedButton(
                child: new Text(
                  'Recuperar contraseña',
                  style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Questrial'
                  ),
                ),
                color: Colors.blue,
                onPressed: _recuperarContrasena,
              ),
            ]),
      ),
    );
  }
}
