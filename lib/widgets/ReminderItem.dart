import 'package:flutter/material.dart';

import '../config/Constants.dart';
// import '../config/Pallete.dart' as Pallete;

class ReminderItem extends StatelessWidget {
  final String idReminder;
  final String contactName;
  final String receiverName;
  final String reminderText;
  final String createdAt;
  final String remindAt;

  ReminderItem({
    @required this.idReminder,
    this.contactName,
    this.receiverName,
    this.reminderText,
    this.createdAt,
    this.remindAt,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Image(
                  image: AssetImage(KRemindSquare),
                  width: kActivityIconWidth,
                  height: kActivityIconHeight,
                  color: null,
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Bạn đã tạo nhắc nhở cho ',
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
                      createdAt,
                      style: kNoteTimeTextStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  // TODO: add MORE functionality
                },
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
              reminderText,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Người nhận tin'),
                      // Spacer(),
                      Container(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          receiverName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4.0),
                  )),
                  child: Column(
                    children: <Widget>[
                      Text('Ngày giờ nhắc nhở'),
                      Container(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          remindAt,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
