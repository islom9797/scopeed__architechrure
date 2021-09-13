import 'package:architechrure/model/post_model.dart';
import 'package:architechrure/services/http_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:architechrure/pages/update_page.dart';
import 'package:architechrure/pages/create_page.dart';


class HomeViewModel extends ChangeNotifier{

  List <Post> items = new List();
  bool isLoading=false;
  notifyListeners();

  Future apiPostList () async {
    isLoading = true;
    notifyListeners();
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null ) {
      items = Network.parsePostList(response);
    } else {
      print ("No info");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> apiCreatePost(BuildContext context) async{
    String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreatPage()));
    items.add(Network.parsePost(result));
    notifyListeners();
  }

  Future<void> apiUpdatePost(BuildContext context,Post post) async{
    String result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdatePage(post: post,)));
    Post post2 = Network.parsePost(result);
    items[items.indexWhere((element) => element.id == post2.id)] = post2;
    notifyListeners();
  }

  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();
    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    print(response);
    if(response != null) {
      apiPostList();
    }
    isLoading = false;
    notifyListeners();
  }
}