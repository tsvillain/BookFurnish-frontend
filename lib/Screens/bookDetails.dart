import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookDetails extends StatefulWidget {
  final String imageUrl, id, name, subject, author, department, bookType;
  BookDetails({
    this.imageUrl,
    this.id,
    this.name,
    this.subject,
    this.author,
    this.department,
    this.bookType,
  });
  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  //bool isLoading = true;
  List book;
  String url =
      "https://fast-everglades-73327.herokuapp.com/api/v1/book/5e5430718e1576265487fb99/";
  // getBooksDetail() async {
  //   print(widget.id);
  //   // String url =
  //   //     "https://fast-everglades-73327.herokuapp.com/api/v1/book/" + widget.id;

  //   print(url);
  //   var res = await http.get(Uri.encodeFull(url));
  //   // Map<String, dynamic> map = json.decode(res.body);
  //   // List<dynamic> data = map["data"]["book"];
  //   List data = json.decode(res.body);
  //   setState(() {
  //     book = data;
  //     isLoading = false;
  //     print(book);
  //   });
  // }

  void initState() {
    super.initState();
    // getBooksDetail();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(widget.imageUrl),
            height: 400,
            width: width,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Title:'),
                  subtitle: Text(widget.name),
                ),
                ListTile(
                  title: Text('Subject:'),
                  subtitle: Text(widget.subject),
                ),
                ListTile(
                  title: Text('Department:'),
                  subtitle: Text(widget.department),
                ),
                ListTile(
                  title: Text('Author:'),
                  subtitle: Text(widget.author),
                ),
                ListTile(
                  title: Text('Book Type'),
                  subtitle: Text(widget.bookType),
                ),
                ButtonTheme(
                  minWidth: width,
                  height: 30,
                  child: RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.green,
                    child: Text(
                      "GET BOOK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
