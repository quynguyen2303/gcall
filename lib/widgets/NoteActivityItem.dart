import 'package:flutter/material.dart';

import '../config/Pallete.dart' as Pallete;
import 'package:gcall/config/Constants.dart';

import '../models/note.dart';

class NoteItem extends StatelessWidget {
  final Note note = Note(
      nameContact: 'Phu Quy',
      noteText: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. ",
      createdAt: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: ImageIcon(
                  AssetImage(kNoteAdd),
                  color: Pallete.primaryColor,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Bạn đã tạo ghi chú cho ${note.nameContact}',
                      style: kContactCallHistoryTextStyle,
                    ),
                    Text(
                      note.date,
                      style: kTimeCallHistoryTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
            child: Text(
              note.noteText,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
