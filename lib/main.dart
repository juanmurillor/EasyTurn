import 'package:flutter/material.dart';
import 'login_page.dart';
import 'root_page.dart';
import 'auth.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{

  @override
    Widget build(BuildContext context) {
      
      return new MaterialApp(
        title: 'EasyTurn',
        debugShowCheckedModeBanner:false,
        theme: new ThemeData(
          primaryColor: Colors.black,

        ),
      home: new RootPage(auth: new Auth())
      );
    }
  
}