import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:BookFurnish/Screens/bookDetails.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  @override
  _DefaultPageState createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  List book;
  final url = "https://fast-everglades-73327.herokuapp.com/api/v1/book";
  getBooks() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> data = map["data"]["book"];
    setState(() {
      book = data;
      isLoading = false;
      print(book.length);
      print(book);
    });
  }

  initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    //final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = (size.width / 2);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : book.length < 1
            ? Center(
                child: Text('No Books Donated Yet..'),
              )
            : GridView.builder(
                itemCount: book.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: (itemWidth / 300)),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookDetails()));
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: <Widget>[
                          Image(
                            image: NetworkImage(
                                'https://randomuser.me/api/portraits/men/9.jpg'),
                            fit: BoxFit.fill,
                            height: 200,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                  text: book[index]['bookName'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
  }

  @override
  bool get wantKeepAlive => true;
}
