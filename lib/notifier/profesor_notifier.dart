import 'package:flutter/cupertino.dart';
import 'package:easy_turn/model/profesores.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';

class ProfesorNotifier with ChangeNotifier{

  List<Profesores> _profesoresList =[];
  Profesores _currentProfesor;

  UnmodifiableListView<Profesores> get profesoresList => UnmodifiableListView(_profesoresList);

  Profesores get currentProfesor => _currentProfesor;

  set profesoresList(List<Profesores> profesoresList){
    _profesoresList = profesoresList;
    notifyListeners();
  }

  set currentProfesor(Profesores profesores){
    _currentProfesor = profesores;
    notifyListeners();
  }

}