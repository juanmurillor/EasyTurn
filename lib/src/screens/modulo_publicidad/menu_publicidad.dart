
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_turn/src/screens/modulo_publicidad/chewie_list_item.dart';



class MenuPublicidadPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState () => new _MenuPublicidadPage();


   

}
class _MenuPublicidadPage extends State<MenuPublicidadPage>{

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Noticias Y Actualidad",style: new TextStyle(
          fontFamily: 'FugazOne',
          fontSize: 23
        ),),
      ),
      body: new  ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
         ChewieListItem(
            videoPlayerController: VideoPlayerController.asset(
              'videos/IntroVideo.mp4',
            ),
            looping: true,
          ),
        
          ],
      ),
    );
  }

    
}
