import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class FooterSlider extends StatefulWidget {
  @override
  _FooterSlider createState() => new _FooterSlider();
}

class _FooterSlider extends State<FooterSlider> {

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
    // TODO: implement build
    return items.length == 0 ? Container(
      height: 0,
    ): Container(
        height: 100.0,
        child: CarouselSlider(
          height: 100.0,
          autoPlay: true,
          items: items.map((item){
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: GestureDetector(
                    child: Image.network(item["image"], fit: BoxFit.fill),
                    onTap: () async {
                        if (await canLaunch(item["url"])) {
                          await launch(item["url"]);
                        } else {
                          throw 'Could not launch ${item["url"]}';
                        }
                    }));
          }).toList(),
        ));
  }

}
