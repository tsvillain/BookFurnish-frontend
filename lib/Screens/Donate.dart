import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DonateBook extends StatefulWidget {
  @override
  _DonateBookState createState() => _DonateBookState();
}

class _DonateBookState extends State<DonateBook> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Book Name',
              ),
              // style: TextStyle(
              //     fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 3),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
              // style: TextStyle(
              //     fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 3),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Department',
              ),
              // style: TextStyle(fontSize: 14, letterSpacing: 3),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Author',
              ),
              //  style: TextStyle(fontSize: 14, letterSpacing: 3),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tags',
              ),
              // style: TextStyle(fontSize: 14, letterSpacing: 3),
            ),
            SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              items: <String>['Book', 'Notes', 'Hand Written Notes']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                print(value);
              },
            ),
            RaisedButton(
              onPressed: () {
                getImage();
              },
              child: Icon(Icons.camera_alt),
            )
          ],
        ),
      ),
    );
  }
}
