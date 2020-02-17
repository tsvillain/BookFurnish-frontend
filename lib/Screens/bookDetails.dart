import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image(
            image:
                NetworkImage('https://randomuser.me/api/portraits/men/9.jpg'),
            height: 300,
            width: width,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
