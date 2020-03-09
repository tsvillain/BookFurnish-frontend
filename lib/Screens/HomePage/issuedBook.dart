import 'dart:convert';
import 'package:BookFurnish/Database/databaseDAO.dart';
import 'package:BookFurnish/Database/userData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//TODO:

class IssuedBook extends StatefulWidget {
  @override
  _IssuedBookState createState() => _IssuedBookState();
}

class _IssuedBookState extends State<IssuedBook> {
  bool isLoading = true;
  List book;
  DatabaseDAO databaseDAO = DatabaseDAO();
  String mID;
  List<UserData> userData;
  getProfile() async {
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
      mID = userData[0].mongoID;
    });
    getBooks();
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  getBooks() async {
    print('inside');
    String url =
        "https://fast-everglades-73327.herokuapp.com/api/v1/borrow/" + mID;
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> data = map["data"]["result"];
    //var data = map["data"]["result"];
    print(data);
    setState(() {
      book = data;
      isLoading = false;
      print(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: book.length,
            itemBuilder: (context, index) {
              var newData = book[index]['bookData'];
              print(newData);
              return Card(
                margin: EdgeInsets.all(10),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Image(
                    image: NetworkImage(newData[index]['bookImage']),
                    fit: BoxFit.fill,
                  ),
                  title: Text(newData['bookName']),
                  subtitle: Text('Author: ' + newData[index]['author']),
                ),
              );
            });
  }
}
