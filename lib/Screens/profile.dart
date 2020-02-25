import 'package:BookFurnish/Database/databaseDAO.dart';
import 'package:BookFurnish/Database/userData.dart';
import 'package:BookFurnish/Screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  DatabaseDAO databaseDAO = DatabaseDAO();
  List<UserData> userData;
  bool editable = false;
  String btnText = 'Edit Profile';
  int rating = 3;
  getProfile() async {
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
      isLoading = false;
    });
  }

  initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.highlight_off),
              onPressed: () {
                databaseDAO.deleteAll();
                Navigator.pushReplacement(
                    context, CupertinoPageRoute(builder: (context) => Login()));
              })
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 40),
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://randomuser.me/api/portraits/men/9.jpg'),
                                    radius: 100.0,
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: RaisedButton(
                                      color: rating > 3
                                          ? Colors.green
                                          : rating > 2
                                              ? Colors.orange
                                              : Colors.red,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                      child: Text(
                                        rating.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                                overflow: Overflow.clip,
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    prefixIcon: Icon(Icons.person_outline),
                                    labelText: userData[0].name,
                                  ),
                                  enabled: editable,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 3),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    prefixIcon: Icon(Icons.credit_card),
                                    labelText: userData[0].enrollment,
                                  ),
                                  enabled: editable,
                                  style:
                                      TextStyle(fontSize: 18, letterSpacing: 2),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    prefixIcon: Icon(Icons.school),
                                    labelText: userData[0].semester,
                                  ),
                                  enabled: editable,
                                  style:
                                      TextStyle(fontSize: 18, letterSpacing: 2),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    prefixIcon: Icon(Icons.email),
                                    labelText: userData[0].email,
                                  ),
                                  enabled: editable,
                                  style:
                                      TextStyle(fontSize: 18, letterSpacing: 2),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    prefixIcon: Icon(Icons.developer_board),
                                    labelText: userData[0].branch,
                                  ),
                                  enabled: editable,
                                  style:
                                      TextStyle(fontSize: 18, letterSpacing: 2),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // OutlineButton(
                                //   borderSide: BorderSide(
                                //       color: Theme.of(context).accentColor),
                                //   onPressed: () {
                                //     setState(() {
                                //       btnText = 'Save Profile';
                                //       editable = true;
                                //     });
                                //   },
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: Text(
                                //     btnText,
                                //     style: TextStyle(fontSize: 15.0),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
