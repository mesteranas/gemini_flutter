import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
class ImageModel extends StatefulWidget{
    @override
  State<ImageModel> createState()=>_IMGModel();
}
class _IMGModel extends State<ImageModel>{
  final TextEditingController _text=TextEditingController();
  String result="";
  String path="";
  final gemini=Gemini.instance;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("image model"),
      ),
      body: Center(child: Column(children: [
        ElevatedButton(onPressed: () async{
          final result=await FilePicker.platform.pickFiles();
          if (result!=Null) {
            path=result?.files.first.path??"";
          }
        }, child: Text("select image")),
        TextFormField(controller: _text,decoration: InputDecoration(labelText:"message" ),),
        ElevatedButton(onPressed:()async{
          File file=await File(path);
                    setState(() {
            result="please wait gemini is writing a message";
          });

          gemini.textAndImage(text: _text.text,images: [file.readAsBytesSync()])
          .then((value){
                      setState(() {
            result=value?.output??"error";
          });

          } )
          .catchError((error){
              setState(() {
            result="error";
          });

          });

        } , child: Text("send message")),
        Text(result)
      ],),),
    );
  }
}