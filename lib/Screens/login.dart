import 'dart:convert';
import 'dart:ui';
import 'package:BookFurnish/Database/databaseDAO.dart';
import 'package:BookFurnish/Database/userData.dart';
import 'package:BookFurnish/Screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'HomePage/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DatabaseDAO databaseDAO = DatabaseDAO();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController enrollmentNO = TextEditingController();
  TextEditingController password = TextEditingController();
  String enroll, pass, email;
  final String loginUrl =
      "https://fast-everglades-73327.herokuapp.com/api/v1/user/signin";
  bool isLoading = false;
  initState() {
    super.initState();
    print('inside login page');
  }

  validateUser() async {
    isLoading = true;
    // final prefs = await SharedPreferences.getInstance();
    Map<String, String> header = {"Content-type": "application/json"};
    String json = '{"email": "' + email + '", "password": "' + pass + '"}';
    Response response = await post(loginUrl, headers: header, body: json);
    var data = jsonDecode(response.body);
    print(data);
    if (data['status'] == 'success') {
      print('inside sucess');
      // prefs.setString('email', email);
      // prefs.setString('password', pass);
      // prefs.setString('token', data['data']['token']);
      databaseDAO.insert(UserData(
        name: data['data']['name'],
        branch: data['data']['branch'],
        semester: data['data']['semester'],
        userType: data['data']['userType'],
        email: email,
        password: pass,
        enrollment: enroll,
        token: data['data']['token'],
      ));
      isLoading = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } else {
      isLoading = false;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Wrong username or password'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/image/login_background.jpg'),
                    fit: BoxFit.fitHeight),
              ),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 1.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 100, 20, 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                fontSize: 40),
                          ),
                          Text(
                            'Book Sharing',
                            style: TextStyle(letterSpacing: 2.0, fontSize: 38),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 70,
                            child: Card(
                              elevation: 100.0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: enrollmentNO,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(15.0),
                                    hintText: 'Enrollment No.',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 70,
                            child: Card(
                              elevation: 100.0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: password,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(15.0),
                                    hintText: 'Password',
                                  ),
                                  obscureText: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonTheme(
                            minWidth: width,
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  enroll = enrollmentNO.text;
                                  email = enroll + "@paruluniversity.ac.in";
                                  pass = password.text;
                                });
                                validateUser();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.green,
                              child: Text(
                                "LOGIN",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account? "),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        CupertinoPageRoute(builder: (context) {
                                      return Signup();
                                    }));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Forget Password? "),
                              GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Reset Password",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            ),
    );
  }
}
