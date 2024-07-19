//操作系統的核心，將動態資料物件化，方便管理

//導入dart:convert，用於處理Json的編碼與解碼
import 'dart:convert';

//建立一個類別，將外部資料格式化(分門歸類，保有的欄位不動)
//此時的資料尚未是json格式
class Post {
  //外部資料中，資料型態是整數的userId歸在一類
  int userId;
  //外部資料中，資料型態是整數的id歸在一類
  int id;
  String title;
  String body;
  //建構子
  Post(this.userId, this.id, this.title, this.body);

  //建立一個函數叫做toJsonObjectString，將物件轉換成json格式的string
  String toJsonObjectString() {
    return jsonEncode({
      'userId': this.userId,
      'id': this.id,
      'title': this.title,
      'body': this.body
    });
  }

  //從未確定格式的大家族dynamic中，篩選出符合json格式的post物件
  factory Post.fromJson(dynamic jsonObject) {
    return Post(jsonObject['userId'], jsonObject['id'], jsonObject['title'],
        jsonObject['body']);
  }
}
