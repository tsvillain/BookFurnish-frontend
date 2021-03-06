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
    var width = MediaQuery.of(context).size.width;
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: book.results.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(30.0, 10, 5, 5),
                        height: 100.0,
                        width: width * 0.75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              book.results[index].bookDatas[0].bookName,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              book.results[index].bookDatas[0].author,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black38),
                            ),
                            Text(
                              book.results[index].bookDatas[0].department,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black38),
                            ),
                          ],
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: 150.0,
                      width: width * 0.25,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                              spreadRadius: 10.0),
                        ],
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image(
                        image: NetworkImage(
                            book.results[index].bookDatas[0].bookImage),
                        fit: BoxFit.fitHeight,
                        height: 150.0,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              );
              // Card(
              //   margin: EdgeInsets.all(10),
              //   clipBehavior: Clip.antiAlias,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: ListTile(
              //     leading: Image(
              //       image: NetworkImage(
              //           book.results[index].bookDatas[0].bookImage),
              //       fit: BoxFit.fill,
              //     ),
              //     title: Text(book.results[index].bookDatas[0].bookName),
              //     subtitle: Text(book.results[index].bookDatas[0].author),
              //   ),
              // );
            });
  }
}
