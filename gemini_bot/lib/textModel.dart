import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
class TextModel extends StatefulWidget{
    @override
  State<TextModel> createState()=>_textModel();
}
class _textModel extends State<TextModel>{
  final TextEditingController _text=TextEditingController();
  String result="";
  final gemini=Gemini.instance;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("text model"),
      ),
      body: Center(child: Column(children: [
        TextFormField(controller: _text,decoration: InputDecoration(labelText:"message" ),),
        ElevatedButton(onPressed:(){
                    setState(() {
            result="please wait gemini is writing a message";
          });

          gemini.text(_text.text)
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