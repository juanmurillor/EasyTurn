import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class PublicidadCarousel extends StatefulWidget {
  @override
  _PublicidadCarouselState createState() => _PublicidadCarouselState();
}

class _PublicidadCarouselState extends State<PublicidadCarousel> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
        height: 200.0,
        child: CarouselSlider(
          height: 200.0,
          items: [
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannermicrositio50.jpg?itok=D-0pOzWQ',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannerppal_mesa_de_trabajo_1_0.jpg?itok=uDic4wao',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannersolicitudcredito735x250-01.jpg?itok=nVHf_ylY',
            'https://www.usbcali.edu.co/sites/default/files/styles/slide/public/bannerinscripciones2020-1.jpg?itok=gn9m88n0'
          ].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: GestureDetector(
                        child: Image.network(i, fit: BoxFit.fill),
                        onTap: () {
                          launchURL() async {
                            const url = 'https://www.usbcali.edu.co/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                        }));
              },
            );
          }).toList(),
        ));
  }
}
