import 'package:BookFurnish/Screens/HomePage/DefaultPage.dart';
import 'package:BookFurnish/Screens/HomePage/issuedBook.dart';
import 'package:BookFurnish/Model/fixedFAb.dart';
import 'package:BookFurnish/Screens/favPage.dart';
import 'package:BookFurnish/Screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  bool showLeading = true;
  Widget appBarTitle = Text("BookFurnish");
  Icon actionIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: appBarTitle,
          centerTitle: true,
          leading: showLeading
              ? IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => ProfilePage()));
                  })
              : null,
          actions: <Widget>[
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(Icons.close);
                    this.showLeading = false;
                    this.appBarTitle = TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.white)),
                    );
                  } else {
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text("BookFurnish");
                    this.showLeading = true;
                  }
                });
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
                icon: Icon(Icons.done), title: Text("Donated")),
            BottomNavigationBarItem(
                icon: Icon(Icons.book), title: Text("Recived"))
          ],
          currentIndex: _selectedIndex,
          onTap: _onTap,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FavPage()));
        },
        child: Icon(Icons.favorite),
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
