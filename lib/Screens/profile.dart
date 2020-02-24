import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editable = false;
  String btnText = 'Edit Profile';
  int rating = 3;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.highlight_off), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
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
                              //child: Image(image: AssetImage('asset/image/login_background.jpg')),
                            ),
                            Positioned(
                              top: 0.0,
                              left: 0.0,
                              child: RaisedButton(
                                color: rating > 3
                                    ? Colors.green
                                    : rating > 2 ? Colors.orange : Colors.red,
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Text(
                                  rating.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       borderRadius: BorderRadius.circular(50.0),
                              //       color: rating > 3
                              //           ? Colors.green
                              //           : rating > 2
                              //               ? Colors.orange
                              //               : Colors.red),
                              //   child: Text(
                              //     rating.toString(),
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //)
                              // IconButton(
                              //   icon: Icon(Icons.near_me),
                              //   // Text(
                              //   //   '5',
                              //   //   style: TextStyle(color: Colors.white),
                              //   // ),
                              //   onPressed: () {},
                              //   color: rating > 3 ? Colors.green : Colors.red,
                              // ),
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
                              labelText: 'Tekeshwar Singh',
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
                              labelText: '190305105722',
                            ),
                            enabled: editable,
                            style: TextStyle(fontSize: 18, letterSpacing: 2),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              prefixIcon: Icon(Icons.cake),
                              labelText: '31-08-2000',
                            ),
                            enabled: editable,
                            style: TextStyle(fontSize: 18, letterSpacing: 2),
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
                              labelText: 'tekeshwarsingh2000@gmail.com',
                            ),
                            enabled: editable,
                            style: TextStyle(fontSize: 18, letterSpacing: 2),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              prefixIcon: Icon(Icons.phone),
                              labelText: '9558180623',
                            ),
                            enabled: editable,
                            style: TextStyle(fontSize: 18, letterSpacing: 2),
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
