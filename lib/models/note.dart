import 'package:flutter/cupertino.dart';
import 'package:gcall/models/activity.dart';

class Note extends Activity {
  final String idNote;
  final String idContact;
  final String contactName;
  String noteText;
  final DateTime createdAt;

  Note({
    @required this.idNote,
    this.idContact,
    this.contactName,
    this.noteText,
    this.createdAt,
  });

  String get date {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} lúc ${createdAt.hour}:${createdAt.minute}';
  }
}
