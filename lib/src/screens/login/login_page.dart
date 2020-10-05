import 'package:easy_turn/src/screens/login/recuperar_contrasena.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'buscar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({this.auth,  this.onSignedInAsCliente});
  final BaseAuth auth;
  
  final VoidCallback onSignedInAsCliente;


 

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final db = Firestore.instance;
 

  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();


  String id;
  String _email;
  String _password;
  String _apellido;
  String _nombre;
  num _telefono;
  String _tipodeusuarios = null;
  List<String> _tipodeusuario = new List<String>();
  
  
  
  

  void initState() {
    _tipodeusuario.addAll(["Cliente"]);
    _tipodeusuarios = _tipodeusuario.elementAt(0);
  }

  void _onChanged(String tipodeusuarios) {
    setState(() {
      _tipodeusuarios = tipodeusuarios;
    });
  }

  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          var userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          FirebaseUser user = await FirebaseAuth.instance.currentUser();
              if(user.isEmailVerified){
          print('sesion iniciada por: $userId');
          var resultado = [];
           widget.onSignedInAsCliente();    

          
  
          Buscar().buscarusuario(_email).then((QuerySnapshot docs) {
            for (int i = 0; i < docs.documents.length; i++) {
              resultado.add(docs.documents[i].data.values.toList());
              print(docs.documents[i].data);
            }
            print(resultado[0][3]);
           
            
          });}else {
                user.sendEmailVerification();
                _scaffoldState.currentState.showSnackBar(new SnackBar(
                  content: new Text(
                    'Verifica tu cuenta para poder iniciar sesion',
                    style: new TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Color(0xFF64FF7F),
                ));
                FirebaseAuth.instance.signOut();
              }
        }else {
          
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print('usuario registrado: $userId');

          //rest spring
          Future<http.Response> guardarUsuario() async {
       var url =  "http://192.168.0.18:8080/easyturn/rest/controllers/usuarios/saveUsuarios"; 
       var tipousuarioid;
       if (_tipodeusuarios == "Restaurante" ){
         tipousuarioid=2;
      }
      if (_tipodeusuarios == "Administrativo" ){
         tipousuarioid=3;
      }
      if (_tipodeusuarios == "Cliente" ){
         tipousuarioid=1;
      }
       Map<String, dynamic> data = 
       {
       'apellido': _apellido,
		   'contraseña': _password,	
		   'email':	_email,
		   'nombre': _nombre,
		   'telefono': _telefono,
       };
       var Body = json.encode(data);
       var response = await http.post(Uri.parse(url),body: Body,headers:{
          "Accept": "application/json",
          "content-type": "application/json"
        } , encoding: Encoding.getByName("utf-8"));
          print("${response.body}");
          print("${response.statusCode}");
          print(Body);
          return response;
     }


      guardarUsuario();

          await db.collection('usuarios').document(userId).setData({
            'nombre': '$_nombre',
            'apellido': '$_apellido',
            'telefono': '$_telefono',
            'email': '$_email'
          });
          setState(() => id = userId);
          _scaffoldState.currentState.showSnackBar(new SnackBar(
            content: new Text(
              'Tu cuenta se ha creado con exito, revisa tu email para verificarla',
              style: new TextStyle(color: Colors.black),
            ),
            backgroundColor: Color(0xFF64FF7F),
          ));
        }
      } catch (e) {
        _scaffoldState.currentState.showSnackBar(new SnackBar(
          content: new Text(
            e.message.toString(),
            style: new TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFC91301),
        ));
      }
      }
    
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  void moveToRecovery(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecuperarContasenaPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldState,
        appBar: new AppBar(
          title: new Text('USB App',style: new TextStyle(
            fontFamily: 'FugazOne',
            fontSize: 30,
            
          ),
          textAlign: TextAlign.center,
          ),
        ),
        body: new ListView(padding: EdgeInsets.all(16.0), children: <Widget>[
          new Image.asset(
            'assets/images/usbapp-logo1.png',
            fit: BoxFit.contain,
          ),
          new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: inputs() + buttons(),
            ),
          ),
        ]));
  }

  List<Widget> inputs() {
    if (_formType == FormType.login) {
      return [
        new TextFormField(
          style: new TextStyle(
            fontFamily: 'Questrial'
          ),
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) =>
              value.isEmpty ? 'El Email no puede estar vacio' : null,
          onSaved: (value) => _email = value.trim(),
        ),
        new TextFormField(
          style: new TextStyle(
            fontFamily: 'Questrial'
          ),
          decoration: new InputDecoration(labelText: 'Contraseña'),
          obscureText: true,
          validator: (value) =>
              value.isEmpty ? 'La Contraseña no puede estar vacia' : null,
          onSaved: (value) => _password = value,
        ),
      ];
    } else {
      return [
        
        new TextFormField(
          style: new TextStyle(
            fontFamily: 'Questrial'
          ),
          decoration: new InputDecoration(labelText: 'Email'),
          validator: (value) =>
              value.isEmpty ? 'El Email no puede estar vacio' : null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          style: new TextStyle(
            fontFamily: 'Questrial'
          ),
          decoration: new InputDecoration(labelText: 'Contraseña'),
          obscureText: true,
          validator: (value) =>
              value.isEmpty ? 'La Contraseña no puede estar vacia' : null,
          onSaved: (value) => _password = value,
        ),
        new TextFormField(
          style: new TextStyle(
            fontFamily: 'Questrial'
          ),
          decoration: new InputDecoration(labelText: 'Nombre'),
          validator: (value) =>
              value.isEmpty ? 'El Nombre no puede estar vacio' : null,
          onSaved: (value) => _nombre = value,
        ),
        new TextFormField(
          style: new TextStyle(
            fontFamily: 'Questrial'
          ),
          decoration: new InputDecoration(labelText: 'Apellido'),
          validator: (value) =>
              value.isEmpty ? 'El Apellido no puede estar vacio' : null,
          onSaved: (value) => _apellido = value,
        ),
        new TextFormField(
          style: new TextStyle(
            fontFamily: 'Questrial'
          ),
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(labelText: 'Telefono'),
          validator: (value) =>
              value.isEmpty ? 'El Telefono no puede estar vacio' : null,
          onSaved: (input) => _telefono = num.parse(input),
        ),
      ];
    }
  }

  List<Widget> buttons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text(
            'Iniciar sesión',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,  
            fontFamily: 'Questrial'
         ),
          ),
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            'Crear cuenta',
            style: new TextStyle(
                fontSize: 18.0,
                color: Colors.red,
                fontWeight: FontWeight.w400,
                fontFamily: 'Questrial'),
          ),
          onPressed: moveToRegister,
        ),
        new FlatButton(
          child: new Text(
            '¿Olvido la contraseña?',
            style: new TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
                fontWeight: FontWeight.w400,
                fontFamily: 'Questrial'),
          ),
          onPressed: moveToRecovery,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text(
            'Crear cuenta',
            style: new TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                 fontFamily: 'Questrial'),
          ),
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            'Ya tienes cuenta? inicia sesión',
            style: new TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
                fontWeight: FontWeight.w400,
                 fontFamily: 'Questrial'),
          ),
          onPressed: moveToLogin,
        ),
        new FlatButton(
          child: new Text(
            '¿Olvido la contraseña?',
            style: new TextStyle(
                fontSize: 18.0,
                color: Colors.blue,
                fontWeight: FontWeight.w400,
                fontFamily: 'Questrial'),
          ),
          onPressed: moveToRecovery,
        ),
      ];
    }
  }
}