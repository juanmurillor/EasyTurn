import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as Img;
import 'package:firebase_storage/firebase_storage.dart';



class CargarImagenPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _CargarImagenPage(); 
   
  }

  class _CargarImagenPage extends State<CargarImagenPage>{

    File image;
    String filename;
    Future _getImage() async {
      var selectedImage = await  ImagePicker.pickImage(source: ImageSource.gallery);
      Img.Image _image = Img.decodeImage(selectedImage.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(_image, 200);
      setState(() {
       image = selectedImage;
       filename = basename(image.path); 
      });
    }
      Future _getImageCamera() async {
      var selectedImage = await  ImagePicker.pickImage(source: ImageSource.camera);
      Img.Image _image = Img.decodeImage(selectedImage.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(_image, 200);
      setState(() {
       image = selectedImage;
       filename = basename(image.path); 
      });
    }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Subir fotos"),
        ),
        body: Center(child: 
        image==null?Text("Selecciona una imagen"):uploadArea(),),
        floatingActionButton: FloatingActionButton(
          onPressed: _getImage,
          tooltip: 'Increment',
          child: Icon(Icons.image),
        ),
     
         
      );
  }
  Widget uploadArea(){
    return Column(children: <Widget>[
      Image.file(image, width: double.infinity,),
      RaisedButton(color: Colors.blueAccent,
      child: Text('Subir Imagen'),
      onPressed: (){
        uploadImage();



      },)    ],);
  }

  Future <String> uploadImage() async{
    StorageReference ref =  FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(image);

    var  downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    print("Download URL : $url");

    return "";
  }
    
  }




  