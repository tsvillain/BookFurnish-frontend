import 'package:BookFurnish/Screens/bookDetails.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:transparent_image/transparent_image.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List book;
  bool isLoading = true;
  final String urlSearch =
      "https://fast-everglades-73327.herokuapp.com/api/v1/book/search";
  getData() async {
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"search": "' + finalSearch + '"}';
    Response res = await post(urlSearch, headers: header, body: json);
    Map<String, dynamic> map = jsonDecode(res.body);
    List<dynamic> data = map["data"]["book"];
    setState(() {
      book = data;
      isLoading = false;
      print(book.length);
      print(book);
    });
  }

  TextEditingController searchController = TextEditingController();
  String finalSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              getData();
            },
          )
        ],
        title: TextFormField(
          controller: searchController,
          style: TextStyle(color: Colors.white),
          autofocus: true,
          onEditingComplete: () {
            setState(() {
              finalSearch = searchController.text;
            });
          },
          decoration: InputDecoration(
              hintText: "Search...", hintStyle: TextStyle(color: Colors.white)),
        ),
      ),
      body: SearchScreen(
        books: book,
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final List books;
  SearchScreen({this.books});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List book;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    setState(() {
      book = widget.books;
    });
    var size = MediaQuery.of(context).size;
    //final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = (size.width / 2);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: book.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: (itemWidth / 320)),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookDetails(
                                    imageUrl: book[index]['bookImage'],
                                    id: book[index]['_id'],
                                    name: book[index]['bookName'],
                                    author: book[index]['author'],
                                    bookType: book[index]['bookType'],
                                    department: book[index]['department'],
                                    subject: book[index]['subject'],
                                  )));
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: <Widget>[
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: book[index]['bookImage'],
                            fit: BoxFit.fill,
                            height: 220,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: StringUtils.capitalize(
                                      book[index]['bookName']),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  )),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
