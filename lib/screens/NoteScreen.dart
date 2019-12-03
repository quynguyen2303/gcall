import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activities_provider.dart';

import '../widgets/ActivityHeaderWidget.dart';

import '../config/Constants.dart';

class NoteScreen extends StatefulWidget {
  static const routeName = './note_screen';
  String idContact;

  NoteScreen({this.idContact});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _validate = false;

  Future<void> createNote(String idContact) async {
    setState(() {
      _textEditingController.text.isEmpty
          ? _validate = true
          : _validate = false;
    });
    if(_validate) {
      return;
    }
    String noteText = _textEditingController.text;
    await Provider.of<Activities>(context, listen: false)
        .createNote(idContact, noteText);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final ActivityHeaderWidget args = ModalRoute.of(context).settings.arguments;
    // widget.idContact = args.idContact;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TẠO GHI CHÚ',
          style: kHeaderTextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              createNote(args.idContact);
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
          controller: _textEditingController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nội Dung',
            errorText: _validate ? 'Nội dung không thể bỏ trống!' : null,
          ),
          maxLines: 10,
          style: kNoteTextStyle,
          // expands: true,
          keyboardType: TextInputType.multiline,
          onSubmitted: (_) {
            createNote(args.idContact);
          },
        ),
      ),
    );
  }
}
