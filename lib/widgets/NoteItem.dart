import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcall/screens/ActivitiesScreen.dart';
import 'package:provider/provider.dart';
import 'package:gcall/providers/activities_provider.dart';

import '../config/Pallete.dart' as Pallete;
import '../config/Constants.dart';

import '../screens/EditNoteScreen.dart';

class NoteItem extends StatelessWidget {
  final String idNote;
  final String noteText;
  final String idContact;
  final String contactName;
  final String date;

  NoteItem({
    @required this.idNote,
    this.noteText,
    @required this.idContact,
    this.contactName,
    this.date,
  });

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
                            text: '$contactName',
                            style: kReminderTitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      date,
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
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: Duration(milliseconds: 700),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  // TODO: Move to Note Screen with pre-info
                                  Navigator.pushNamed(
                                    context,
                                    EditNoteScreen.routeName,
                                    arguments: NoteItem(
                                      idContact: this.idContact,
                                      idNote: this.idNote,
                                      noteText: this.noteText,
                                    ),
                                  );
                                },
                                child: Text('Sửa hoạt động'),
                              ),
                              Divider(),
                              FlatButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Xoá Ghi chú!'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'Xoá',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.redAccent,
                                            onPressed: () async {
                                              await Provider.of<Activities>(
                                                      context,
                                                      listen: false)
                                                  .deleteNote(this.idContact,
                                                      this.idNote);
                                              Navigator.popUntil(
                                                  context,
                                                  ModalRoute.withName(
                                                      ActivitiesScreen
                                                          .routeName));
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Huỷ'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text('Xoá hoạt động'),
                              ),
                              Divider(
                                endIndent: 0,
                                thickness: 5,
                                // color: Colors.grey,
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'ĐÓNG',
                                  style: TextStyle(color: Pallete.primaryColor),
                                ),
                              )
                            ],
                          ),
                          margin:
                              EdgeInsets.only(bottom: 50, left: 50, right: 50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return SlideTransition(
                        position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
            child: Text(
              noteText,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
