import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';

class MenuEnteratePage extends StatefulWidget {
  @override
  _MenuEnteratePage createState() => _MenuEnteratePage();
}

class _MenuEnteratePage extends State<MenuEnteratePage> {
  List items = [];
  obtenerInformacion() async {
    var response = await http.get('https://www.usbcali.edu.co/');
    var document = parse(response.body);
    var slider = document.getElementById("flexslider-2");
    var linkFooter = slider.getElementsByTagName("a");
    List urls = [];
    for (var link in linkFooter) {
      var href = link.attributes["href"];
      var image = link.getElementsByTagName("img");
      var src = image[0].attributes["src"];
      urls.add({"url": href, "image": src});
    }
    setState(() {
      items = urls;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerInformacion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Noticias',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: 'Questrial',
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Colors.blue,
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                    "https://apolox.usbcali.edu.co/SIGU/img/general/logousb_hori.png",
                ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(items.map((item) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: new FlatButton(
                  child: Container(
                    child: FittedBox(
                      child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(0x802196F3),
                        child:  Container(
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.cover,
                                alignment: Alignment.topRight,
                                image: NetworkImage(
                                    item["image"]),
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (await canLaunch(item["url"])) {
                      await launch(item["url"]);
                    } else {
                      throw 'Could not launch ${item["url"]}';
                    }
                  },
                ),
              );
            }).toList()),
          ),
        ],
      )),
    );
  }
}
