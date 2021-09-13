import 'package:architechrure/model/post_model.dart';
import 'package:architechrure/services/http_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class Createviewmodel extends ChangeNotifier{
  bool isLoading = false;
  var titleController = TextEditingController();
  var postController = TextEditingController();

  Future apiCreatPost (BuildContext context) async{
    isLoading = true;
     notifyListeners();
    String title = titleController.text.trim().toString();
    String body = postController.text.trim().toString();
    Post post = Post(title: title, body: body, userId: 1);
    var response =  await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    print (response);
    isLoading = false;
    notifyListeners();
    if (response != null) {
      Navigator.pop(context, response);
    } else {
      print ("Not created");
    }
    notifyListeners();
  }
}