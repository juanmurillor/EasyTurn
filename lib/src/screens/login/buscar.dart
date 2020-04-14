import 'package:cloud_firestore/cloud_firestore.dart';

class Buscar{
  buscarusuario(String correo){
    return Firestore.instance.collection('usuarios').where('email', isEqualTo:correo).getDocuments();
  }
  buscarTurnoRegular(String correo){
    return Firestore.instance.collection('TurnosAcademico').where('email', isEqualTo:correo).getDocuments();
  }
  buscarTurnoReservado(String correo){
    return Firestore.instance.collection('TurnosReservadosAcademico').where('email', isEqualTo:correo).getDocuments();
  }
  buscarCarrito(String correo){
    return Firestore.instance.collection('ShoppingCar').where('emailUsuario', isEqualTo:correo).getDocuments();
  }
}