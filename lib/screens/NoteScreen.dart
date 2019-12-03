import 'package:flutter/material.dart';

import '../config/Constants.dart';

class NoteScreen extends StatefulWidget {
  static const routeName = './note_screen';

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  void createNote() {
    // TODO: send the new note to server
    String noteText = _textEditingController.text;
    
  }
  
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
            onPressed: createNote,
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
          controller: _textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nội Dung',
          ),
          maxLines: 10,
          style: kNoteTextStyle,
          // expands: true,
          keyboardType: TextInputType.multiline,
          onSubmitted: (_) {
            createNote();
          },
        ),
      ),
    );
  }
}
