//設定項目：如何從外部資料系統中，讀取資料，並轉換成資料物件

//引入剛完成物件化的資料檔
import 'package:flutter_application_5/models/post.dart';
//操作系統的核心，把動態資料物件化，方便管理
import 'dart:convert';
//引入外部資料的http套件，用于发送HTTP请求
import 'package:http/http.dart' as http;

//建立PostDao函式
class PostDao {
  //撰寫一個讀取資料的方法
  static Future<List<Post>> getPosts() async {
    //解析外部系統的資料格式
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    //透過http組件，使用get函數，向外部索取內容
    var respones = await http.get(url);
    //將外部取回的內容轉化成List<dynamic>，並透過map迴圈，將dynamic逐一轉換成post物件
    List<Post> posts =
        (jsonDecode(respones.body) as List<dynamic>).map((jsonObject) {
      return Post.fromJson(jsonObject);
    }).toList();
    //傳回所有已轉換成post的物件
    return posts;
  }
}
