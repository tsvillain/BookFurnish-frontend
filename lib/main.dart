import 'package:BookFurnish/Database/databaseDAO.dart';
import 'package:BookFurnish/Database/userData.dart';
import 'package:BookFurnish/Screens/HomePage/home.dart';
import 'package:BookFurnish/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookShare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // darkTheme: ThemeData.dark(),
      home: MyHomePage(),
      //MyHomePage(title: 'Book Sharing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  DatabaseDAO databaseDAO = DatabaseDAO();
  List<UserData> userData;
  checkLogin() async {
    List _userData = await databaseDAO.getAllSortedByID();
    setState(() {
      userData = _userData;
      isLoading = false;
    });
    if (userData.length == 1) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
