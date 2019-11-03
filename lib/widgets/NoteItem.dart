import 'package:flutter/material.dart';

import '../config/Pallete.dart' as Pallete;
import 'package:gcall/config/Constants.dart';

import '../models/note.dart';

class NoteItem extends StatelessWidget {
  final Note note = Note(
      contactName: 'Phu Quy',
      noteText:
          "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. ",
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
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Image(
                  image: AssetImage(kNoteSquare),
                  width: kActivityIconWidth,
                  height: kActivityIconHeight,
                  color: null,
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Bạn đã tạo ghi chú cho ',
                        style: kNormalTextStyle,
                        children: [
                          TextSpan(
                            text: '${note.contactName}',
                            style: kReminderTitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      note.date,
                      style: kTimeCallHistoryTextStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: ImageIcon(
                  AssetImage(kMoreButton),
                  size: 16,
                ),
                onPressed: () {
                  // TODO: add MORE functionality
                },
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
