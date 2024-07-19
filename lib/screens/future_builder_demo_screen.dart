//與外部系統要求外部資料

//引入UI設計包，包含UI設計組件、布局組件、主題管理、導航與路由等
import 'package:flutter/material.dart';
//安裝http套件，以透過http協定，與外部要求資料
import 'package:http/http.dart' as http;

//建立FutureBuilderDemoScreen類別，並繼承StatelessWidget
class FutureBuilderDemoScreen extends StatelessWidget {
  //我們不能確定與外部要求資料的回應時間，因此會用Future進行畫面的初步渲染
  //告知flutter，不讓主程序等待
  Future<dynamic> getDataFromRemote() async {
    //解讀/解析遠端系統網址
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    //建立一個變數，目的是透過http的get方法取得外部資料
    var response = await http.get(url);
    //最後回傳外部資料(使用變數回傳)
    return response.body;
  }

  @override
  //在此實踐StatelessWidget的build方法
  Widget build(BuildContext context) {
    //使用FutureBuilder建構子來回傳
    //兩大核心參數future、builder
    return FutureBuilder(
        //future:接外部取得的資料(這裡是用上方getDataFromRemote函數取得)
        future: getDataFromRemote(),
        //builder有固定兩個參數BuildContext、AsyncSnapshot<T>
        //BuildContext：記錄所有context的參數
        //AsyncSnapshot<T>:接Future傳回來的結果
        builder: (BuildContext context, AsyncSnapshot<dynamic> asyncSnapshot) {
          //建構UI頁面
          return Scaffold(
            //置入剛取得的外部資料近來
            body: Text(asyncSnapshot.data),
          );
        });
  }
}
