import 'package:cloud_firestore/cloud_firestore.dart';

class Buscar{
  buscarusuario(String correo){
    return Firestore.instance.collection('usuarios').where('email', isEqualTo:correo).getDocuments();
  }
}