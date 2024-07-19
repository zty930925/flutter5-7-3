import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application_5/models/post.dart';
import 'package:http/http.dart' as http;

class PostsTableWithSearchEdit extends StatefulWidget {
  List<Post> posts;
  PostsTableWithSearchEdit(this.posts);
  @override
  State createState() {
    return _PostsTableWithSearchEdit();
  }
}

class _PostsTableWithSearchEdit extends State<PostsTableWithSearchEdit> {
  List<Post> filteredPosts = [];
  void changFilteredPosts(String userInput) {
    filteredPosts = this.widget.posts.where((element) {
      if (userInput == '') {
        return true;
      } else if (element.title.contains(userInput)) {
        print(element.title);
        return true;
      } else if (element.body.contains(userInput)) {
        print(element.body);
        return true;
      } else {
        return false;
      }
    }).toList();

    if (filteredPosts.length == 0) {
      filteredPosts.add(Post(999, 999, "查無資料", "查無資料"));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (filteredPosts.length == 0) {
      changFilteredPosts('');
    }
    var searchTextEditingController = TextEditingController();

    //搜尋框SearchBar
    Widget SearchBar = TextField(
      controller: searchTextEditingController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'Enter a search term'),
      onSubmitted: (inputStr) {
        setState(() {
          changFilteredPosts(inputStr);
        });
      },
    );
    List<String> columnName = (jsonDecode(filteredPosts[0].toJsonObjectString())
            as Map<String, dynamic>)
        .keys
        .toList();

    List<DataColumn> dataColumns = columnName.map((key) {
      return DataColumn(
        label: Text(key),
      );
    }).toList();

    List<DataRow> dataRows = filteredPosts.map((post) {
      Map<String, dynamic> postJson =
          jsonDecode(post.toJsonObjectString()) as Map<String, dynamic>;

      List<DataCell> dataCells = columnName.map((key) {
        return DataCell(TextField(
          controller: TextEditingController(text: postJson[key].toString()),
          onSubmitted: (inputStr) {
            postJson[key] = inputStr;
            print(postJson);
            var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
            var responseOfFuture = http.post(url, body: jsonEncode(postJson));
            responseOfFuture.then((value) => print(value.body));
          },
        ));
      }).toList();
      return DataRow(cells: dataCells);
    }).toList();

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              width: 800,
              child: SearchBar,
            ),
            Container(
                width: 800,
                child: DataTable(
                  columns: dataColumns,
                  rows: dataRows,
                )),
          ],
        ),
      ),
    );
  }
}
