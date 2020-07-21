import 'package:basic_utils/basic_utils.dart';
import 'package:easy_turn/src/screens/modulo_cliente/menu_de_turnos/menu_turnos.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuProfesoresPage extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  MenuProfesoresPage({Key key, @required this.documentSnapshot}):super(key: key);

  @override
  State<StatefulWidget> createState() => new _MenuProfesoresPage();
}

class _MenuProfesoresPage extends State<MenuProfesoresPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringUtils.capitalize(widget.documentSnapshot.data["nombre"]),
            style: new TextStyle(fontFamily: 'FugazOne', fontSize: 23),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("usuarios")
                    .where("programa", isEqualTo: widget.documentSnapshot.reference)
                .where("docente", isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasError) return Text('Error');

                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final list = querySnapshot.data.documents;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                            width: 120,
                            fit: BoxFit.fitWidth,),
                          title: Text(list[index]['nombre']+' '+list[index]['apellido']),
                          subtitle: Text(StringUtils.capitalize(widget.documentSnapshot.data["nombre"]) ),
                          onTap: (){
                            DocumentSnapshot profesorList = list[index];
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MenuTurnosPage(documentSnapshot:profesorList ,))
                            );
                          },
                        );
                      },
                      itemCount: list.length,
                      separatorBuilder: (BuildContext context, int index ){
                        return Divider(
                          color:Colors.black,

                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
