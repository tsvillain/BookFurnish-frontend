import 'dart:convert';

import 'package:BookFurnish/Screens/Donate.dart';
import 'package:BookFurnish/Screens/HomePage/DefaultPage.dart';
import 'package:BookFurnish/Screens/HomePage/issuedBook.dart';
import 'package:BookFurnish/Model/fixedFAb.dart';
import 'package:BookFurnish/Screens/favPage.dart';
import 'package:BookFurnish/Screens/profile.dart';
import 'package:BookFurnish/Screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  List book;
  // String finalSearch;
  // final urlSearch =
  //     "https://fast-everglades-73327.herokuapp.com/api/v1/book/search";
  int _selectedIndex = 0;
  // bool showLeading = true;
  // Widget appBarTitle = Text("BookFurnish");
  // Icon actionIcon = Icon(Icons.search);
  TextEditingController searchcontroller = TextEditingController();
  // requestData() async {
  //   Map<String, String> header = {"Content-type": "application/json"};
  //   String json = '{"search": "' + finalSearch + '"}';
  //   Response response = await post(urlSearch, headers: header, body: json);
  //   var data = jsonDecode(response.body);
  //   print(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("BookFurnish"),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => ProfilePage()));
              }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Search()));
                // setState(() {
                //   if (this.actionIcon.icon == Icons.search) {
                //     this.actionIcon = Icon(Icons.close);
                //     this.showLeading = false;
                //     this.appBarTitle = TextFormField(
                //       controller: searchcontroller,
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //       autofocus: true,
                //       onEditingComplete: () {
                //         setState(() {
                //           finalSearch = searchcontroller.text;
                //         });
                //         print(finalSearch);
                //         //requestData();
                //       },
                //       decoration: InputDecoration(
                //           prefixIcon: Icon(Icons.search, color: Colors.white),
                //           hintText: "Search...",
                //           hintStyle: TextStyle(color: Colors.white)),
                //     );
                //   } else {
                //     this.actionIcon = Icon(Icons.search);
                //     this.appBarTitle = Text("BookFurnish");
                //     this.showLeading = true;
                //   }
                // });
              },
            ),
          ]),
      body: getScreen(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 5.0,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), title: Text("Explore")),
            BottomNavigationBarItem(
                icon: Icon(Icons.book), title: Text("Received"))
          ],
          currentIndex: _selectedIndex,
          onTap: _onTap,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DonateBook()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FixedCenterDockedFabLocation(context: context),
    );
  }

  getScreen(int position) {
    if (position == 0) {
      return DefaultPage();
    }
    if (position == 1) {
      return IssuedBook();
    }
  }

  _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
