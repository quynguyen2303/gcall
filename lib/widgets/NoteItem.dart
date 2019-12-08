import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/Pallete.dart' as Pallete;
import 'package:gcall/config/Constants.dart';

class NoteItem extends StatelessWidget {
  final String noteText;
  final String contactName;
  final String date;

  NoteItem({this.noteText, this.contactName, this.date});

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
                  print('Button clicked');
                  // TODO: add MORE functionality
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
                                  Navigator.pop(context);
                                },
                                child: Text('Sửa hoạt động'),
                              ),
                              Divider(),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                                child: Text('ĐÓNG', style: TextStyle(color: Pallete.primaryColor),),
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
