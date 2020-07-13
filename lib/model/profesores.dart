import 'package:cloud_firestore/cloud_firestore.dart';

class Profesores{
  String nombre;
  String apellido;
  String id;
  String programa;
  Timestamp fechaCreacion;

  Profesores.fromMap(Map<String, dynamic> data){
    nombre = data['Nombre'];
    apellido = data['Apellido'];
    id = data['id'];
    programa = data['Programa'];
    fechaCreacion = data['FechaCreacion'];
    
  }

 }