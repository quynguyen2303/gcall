import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/activities_provider.dart';

import '../config/Constants.dart';

import 'ContactDetailScreen.dart';
import 'ActivitiesScreen.dart';

class EditNoteScreen extends StatefulWidget {
  static const routeName = './edit_note_screen';
  final String idContact;
  final String idNote;
  final String previousNoteText;

  EditNoteScreen({
    this.idContact,
    this.idNote,
    this.previousNoteText,
  });

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController _textEditingController;
  bool _validated = true;

  Future<void> createOrUpdateNote(String idContact) async {
    setState(() {
      _textEditingController.text.isEmpty
          ? _validated = false
          : _validated = true;
    });
    if (!_validated) {
      return;
    }
    String noteText = _textEditingController.text;
    await Provider.of<Activities>(context, listen: false)
        .updateNote(idContact, widget.idNote, noteText);
    // Provider.of<Activities>(context, listen: false).clearActivities();
    Navigator.popUntil(
      context,
      ModalRoute.withName(ActivitiesScreen.routeName),
    );
    // await Future.delayed(Duration(milliseconds: 100));
    // Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.previousNoteText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SỬA GHI CHÚ',
          style: kHeaderTextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              createOrUpdateNote(widget.idContact);
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
            errorText: !_validated ? 'Nội dung không thể bỏ trống!' : null,
          ),
          maxLines: 10,
          style: kNoteTextStyle,
          // expands: true,
          keyboardType: TextInputType.multiline,
          onSubmitted: (_) {
            createOrUpdateNote(widget.idContact);
          },
        ),
      ),
    );
  }
}
