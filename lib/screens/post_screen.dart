//該檔案存在的作用：集合各組件模組，湊在同一個頁面中
import 'package:flutter/material.dart';
//import 'package:flutter_application_4/commponents/post_table_with_search.dart';
import 'package:flutter_application_5/commponents/post_table_with_search_and_edit.dart';
import 'package:flutter_application_5/models/post.dart';
import 'package:flutter_application_5/daos/post_dao.dart';

class PostScreen extends StatefulWidget {
  @override
  State createState() {
    return _PostScreen();
  }
}

class _PostScreen extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PostDao.getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Post>> asyncOfPosts) {
          return Scaffold(
            body: PostsTableWithSearchEdit(asyncOfPosts.requireData),
          );
        });
  }
}
