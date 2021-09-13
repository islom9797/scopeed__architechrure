import 'package:architechrure/model/post_model.dart';
import 'package:architechrure/services/http_request.dart';
import 'package:architechrure/viewmodel/createviewmodel.dart';
import 'package:flutter/material.dart';

class CreatPage extends StatefulWidget {

  static final String id = "creat_page";

  @override
  _CreatPageState createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  Createviewmodel viewmodel=Createviewmodel();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Creat Post"),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(

                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: TextField(
                      controller: viewmodel.titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder (),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    height: 100,
                    width: double.infinity,
                    child: TextField(
                      controller: viewmodel.postController,
                      decoration: InputDecoration(
                        labelText: "Post",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      viewmodel.apiCreatPost (context);
                    },
                    child: Text("Creat post"),
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            viewmodel.isLoading ? Center (
              child: CircularProgressIndicator(),
            ) : SizedBox.shrink(),

          ],
        )
    );
  }
}