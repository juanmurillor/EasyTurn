import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Restaurante{
     int idRestaurante;
     String descripcionRestaurante;
     String emailUsuario;
     String nombreRestaurante;
     int telefonoRestaurante;
     String urlFotoRestaurante;

Restaurante({
  this.idRestaurante,
  this.descripcionRestaurante,
  this.emailUsuario,
  this.nombreRestaurante,
  this.telefonoRestaurante,
  this.urlFotoRestaurante

});

factory Restaurante.fromJson(Map<String, dynamic> json){
  return Restaurante(
    idRestaurante: json["idRestaurante"],
    descripcionRestaurante: json["descripcionRestaurante"],
    emailUsuario: json["emailUsuario"],
    nombreRestaurante: json["nombreRestaurante"],
    telefonoRestaurante: json["telefonoRestaurante"],
    urlFotoRestaurante: json["urlFotoRestaurante"],
  );


}

}