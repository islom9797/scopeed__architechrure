import 'package:architechrure/model/post_model.dart';
import 'package:architechrure/services/http_request.dart';
import 'package:architechrure/viewmodel/homeviewmodel.dart';
import 'package:architechrure/viewmodel/updateviewmdoel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdatePage extends StatefulWidget {

  static final String id = "update_page";
  final Post post;


  UpdatePage({this.post});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Updateviewmodel scopedModell=Updateviewmodel();

  @override
  void initState() {
    super.initState();
    scopedModell.getOldPost(widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update post'),
      ),
      backgroundColor: Colors.white,
      body: ScopedModel<Updateviewmodel>(
        model: scopedModell,
        child: ScopedModelDescendant<Updateviewmodel>(
          builder: (context,child,model)=>Stack(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: scopedModell.titleController,
                      decoration: InputDecoration(
                        labelText: "Post Title",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(right: 15, left: 15),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: scopedModell.bodyController,
                      decoration: InputDecoration(
                        labelText: "Post Body",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(
                            right: 15, top: 15, bottom: 50, left: 15),
                      ),
                      maxLines: 7,
                    ),
                    SizedBox(height: 30,),
                    RaisedButton(
                      onPressed: () {
                        scopedModell.apiCreatePost(context);
                      },
                      child: Text ("Update"),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),

              scopedModell.isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink(),
            ],
          ),
        ),
      )
    );
  }
}