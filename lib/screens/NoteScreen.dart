import 'package:flutter/material.dart';

import '../config/Constants.dart';

class NoteScreen extends StatelessWidget {
  static const routeName = './note_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TẠO GHI CHÚ',
          style: kHeaderTextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // TODO: XONG
            },
            child: Text(
              'XONG',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nội Dung',
          ),
          maxLines: 10,
          style: kNoteTextStyle,
          // expands: true,
          keyboardType: TextInputType.multiline,
          onSubmitted: (value) {
            // TODO: submit the note to server
          },
        ),
      ),
    );
  }
}
