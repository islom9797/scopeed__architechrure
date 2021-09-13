
import 'package:architechrure/model/post_model.dart';
import 'package:architechrure/pages/update_page.dart';
import 'package:architechrure/services/http_request.dart';
import 'package:architechrure/viewmodel/homeviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'create_page.dart';


class HomePage extends StatefulWidget {
  static final String id = "home_page";


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  // List <Post> items = new List();
  // bool isLoading;
  //
  // void _apiPostList () async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
  //   setState(() {
  //     if (response != null ) {
  //       items = Network.parsePostList(response);
  //     } else {
  //       print ("No info");
  //     }
  //     isLoading = false;
  //   });
  // }
  //
  // void _apiCreatePost() async{
  //   String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatPage()));
  //   setState(() {
  //     items.add(Network.parsePost(result));
  //   });
  // }
  //
  // void _apiUpdatePost(Post post) async{
  //   String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePage(post: post,)));
  //   setState(() {
  //     Post post2 = Network.parsePost(result);
  //     items[items.indexWhere((element) => element.id == post2.id)] = post2;
  //   });
  // }
  //
  // void _apiPostDelete(Post post) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
  //   print(response);
  //   setState(() {
  //     if(response != null) {
  //       _apiPostList();
  //     }
  //     isLoading = false;
  //   });
  // }
  HomeViewModel viewmodel=HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SetState"),
      ),
      body: ChangeNotifierProvider(
        create: (context)=>viewmodel,
        child: Consumer<HomeViewModel>(
          builder: (ctx,model,index)=>Stack(
            children: [
              ListView.builder(
                itemCount: viewmodel.items.length,
                itemBuilder: (ctx, index) {
                  return itemList (viewmodel.items[index]);
                },
              ),
              viewmodel.isLoading ? Center (
                child: CircularProgressIndicator(),
              ) : SizedBox.shrink(),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          viewmodel.apiCreatePost(context);
        },
      ),

    );
  }



  Widget itemList (Post post) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title.toUpperCase(), style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(post.body, style: TextStyle(color: Colors.blueGrey),),
          ],
        ),
      ),
      actions: [
        IconSlideAction(
          caption:  "Update",
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: (){
            viewmodel.apiUpdatePost(context,post);
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
          onTap: (){
            viewmodel.apiPostDelete(post);
          },
        ),
      ],
    );
  }
}
