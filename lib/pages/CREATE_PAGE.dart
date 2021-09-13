import 'package:architechrure/model/post_model.dart';
import 'package:architechrure/services/http_request.dart';
import 'package:flutter/material.dart';

class CreatPage extends StatefulWidget {

  static final String id = "creat_page";

  @override
  _CreatPageState createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {
  bool isLoading = false;
  var titleController = TextEditingController();
  var postController = TextEditingController();

  _apiCreatPost () async{
    setState(() {
      isLoading = true;
    });
    String title = titleController.text.trim().toString();
    String body = postController.text.trim().toString();
    Post post = Post(title: title, body: body, userId: 1);
    var response =  await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    print (response);
    setState(() {
      isLoading = false;
      if (response != null) {
        Navigator.pop(context, response);
      } else {
        print ("Not created");
      }
    });
  }


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
                      controller: titleController,
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
                      controller: postController,
                      decoration: InputDecoration(
                        labelText: "Post",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      _apiCreatPost ();
                    },
                    child: Text("Creat post"),
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            isLoading ? Center (
              child: CircularProgressIndicator(),
            ) : SizedBox.shrink(),

          ],
        )
    );
  }
}