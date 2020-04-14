import 'package:flutter/material.dart';
import 'src/screens/login/login_page.dart';
import 'src/screens/login/auth.dart';
import 'src/screens/modulo_cliente/cliente_page.dart';
import 'root_page.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/Auth': (BuildContext context) => new LoginPage()
  };

  Routes() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(new MaterialApp(
      title: 'EasyTurn',
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new RootPage(auth: new Auth()),
    ));
  }
}
