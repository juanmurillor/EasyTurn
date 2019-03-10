import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
class LoginPage extends StatefulWidget{

  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
    State<StatefulWidget> createState() => new _LoginPageState();

}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage>{

  final db = Firestore.instance;

  final formKey = new GlobalKey<FormState>();

  String id;
  String _email;
  String _password;
  String _apellido;
  String _nombre;
  num _telefono;
  List<DropdownMenuItem<int>> _tipodeusuario = [];

  void loadData(){
    _tipodeusuario = [];
    _tipodeusuario.add(new DropdownMenuItem(
      child: new Text('Cliente'),
      value: 1,
    ));
      _tipodeusuario.add(new DropdownMenuItem(
      child: new Text('Restaurante'),
      value: 2,
    ));
      _tipodeusuario.add(new DropdownMenuItem(
      child: new Text('Administrador'),
      value: 3,
    ));
  }
 




  
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    } 
    return false;
  }

  void validateAndSubmit() async{
    if(validateAndSave()){
      try{
      if(_formType == FormType.login){
        String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
        print('sesion iniciada por: $userId');
      }else{
        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
        print('usuario registrado: $userId');

        DocumentReference ref = await db.collection('usuarios').add({
          'nombre': '$_nombre',
          'apellido': '$_apellido',
          'telefono': '$_telefono',
          'email': '$_email',
          'contraseña': '$_password'
          });
        setState(() => id = ref.documentID); 
        print(ref.documentID);          
        }
        widget.onSignedIn();
      }
      catch(e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
          _formType = FormType.register;
        });

  }
  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
          _formType = FormType.login;
        });

  }

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Easy Turn'),
          ),
        body: 
        new ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
            new Image.asset('assets/images/et-logo1.png',
            fit: BoxFit.contain,),
              new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: inputs() + buttons(),
                ),
              ),
            ]
          )

      );
    }
    List<Widget> inputs(){
      if(_formType == FormType.login){
      return[
           new TextFormField(
                    decoration: new InputDecoration(labelText: 'Email'),
                    validator: (value) => value.isEmpty ? 'El Email no puede estar vacio' : null,  
                    onSaved: (value) => _email = value,                 
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    validator: (value) => value.isEmpty ? 'La Contraseña no puede estar vacia' : null,
                    onSaved: (value) => _password = value,                   
                  ),
      ];
      }else{
        return[
           
           new TextFormField(
                    decoration: new InputDecoration(labelText: 'Email'),
                    validator: (value) => value.isEmpty ? 'El Email no puede estar vacio' : null,  
                    onSaved: (value) => _email = value,                 
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    validator: (value) => value.isEmpty ? 'La Contraseña no puede estar vacia' : null,
                    onSaved: (value) => _password = value,                   
                  ),
                    new TextFormField(
                    decoration: new InputDecoration(labelText: 'Nombre'),
                    validator: (value) => value.isEmpty ? 'El Nombre no puede estar vacio' : null,  
                    onSaved: (value) => _nombre = value,                 
                  ),
                  new TextFormField(
                    decoration: new InputDecoration(labelText: 'Apellido'),
                    validator: (value) => value.isEmpty ? 'El Apellido no puede estar vacio' : null,
                    onSaved: (value) => _apellido = value,                   
                  ),
                   new TextFormField(
                    keyboardType: TextInputType.number, 
                    decoration: new InputDecoration(labelText: 'Telefono'),
                    validator: (value) => value.isEmpty ? 'El Telefono no puede estar vacio' : null,
                    onSaved: (input) => _telefono = num.parse(input),                   
                  ),
                
      ];

      }

    }
     List<Widget> buttons(){
      if(_formType == FormType.login){
       return[
          new RaisedButton(
                    child: new Text('Iniciar sesión', style: new TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400 ),),
                    color: Colors.blue,
                    onPressed: validateAndSubmit,
                  ),
                  new FlatButton(
                    child: new Text('Crear cuenta', style: new TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w400 ), ),
                    onPressed: moveToRegister,
                  ),
       ];
      }else {
         return[
          new RaisedButton(
                    child: new Text('Crear cuenta', style: new TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400 ),),
                    color: Colors.blue,
                    onPressed: validateAndSubmit,
                  ),
                  new FlatButton(
                    child: new Text('Ya tienes cuenta? inicia sesión', style: new TextStyle(fontSize: 18.0, color: Colors.blue, fontWeight: FontWeight.w400 ), ),
                    onPressed: moveToLogin,
                  ),
       ];
      }     
      }


}
