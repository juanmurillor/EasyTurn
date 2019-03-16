import 'package:flutter/material.dart';
import 'src/screens/login/login_page.dart';
import 'src/root_page.dart';
import 'src/screens/login/auth.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/Auth': (BuildContext context) => new LoginPage()
  };

  Routes() {
    runApp(new MaterialApp(
      title: 'EasyTurn',
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new LoginPage(auth: new Auth()),
    ));
  }
}
