import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_turn/src/screens/login/auth.dart';


class PedidoRestaurante extends StatefulWidget {
  PedidoRestaurante({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _PedidoRestauranteState createState() => _PedidoRestauranteState();
}

class _PedidoRestauranteState extends State<PedidoRestaurante> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}