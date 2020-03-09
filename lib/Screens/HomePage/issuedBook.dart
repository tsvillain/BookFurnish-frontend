import 'dart:convert';
import 'package:BookFurnish/Database/databaseDAO.dart';
import 'package:BookFurnish/Database/userData.dart';
import 'package:BookFurnish/Model/borrowedBook.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IssuedBook extends StatefulWidget {
  @override
  _IssuedBookState createState() => _IssuedBookState();
}

class _IssuedBookState extends State<IssuedBook> {
  bool isLoading = true;
  Product book;
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
    String url =
        "https://fast-everglades-73327.herokuapp.com/api/v1/borrow/" + mID;
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    Map<String, dynamic> map = json.decode(res.body);
    var borrowedBook = Product.fromJson(map);
    setState(() {
      book = borrowedBook;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: book.results.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Image(
                    image: NetworkImage(
                        book.results[index].bookDatas[0].bookImage),
                    fit: BoxFit.fill,
                  ),
                  title: Text(book.results[index].bookDatas[0].bookName),
                  subtitle: Text(book.results[index].bookDatas[0].author),
                ),
              );
            });
  }
}
