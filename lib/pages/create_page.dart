import 'package:architechrure/model/post_model.dart';
import 'package:architechrure/services/http_request.dart';
import 'package:architechrure/viewmodel/createviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CreatPage extends StatefulWidget {

  static final String id = "creat_page";

  @override
  _CreatPageState createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  CreateScopemodel scopemodel=CreateScopemodel();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Creat Post"),
        ),
        body: ScopedModel(
          model: scopemodel,
          child: ScopedModelDescendant(
            builder: (ctx,child,model)=>Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(

                    children: [
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: TextField(
                          controller: scopemodel.titleController,
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
                          controller: scopemodel.postController,
                          decoration: InputDecoration(
                            labelText: "Post",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: (){
                          scopemodel.apiCreatPost (context);
                        },
                        child: Text("Creat post"),
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                scopemodel.isLoading ? Center (
                  child: CircularProgressIndicator(),
                ) : SizedBox.shrink(),

              ],
            ),
          ),
        )
    );
  }
}