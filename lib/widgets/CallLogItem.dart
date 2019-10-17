import 'package:flutter/material.dart';
import '../config/Constants.dart';
import '../config/Pallete.dart' as Pallete;

class CallLogItem extends StatelessWidget {
  final String name;
  final String initialLetter;
  final String date;
  final String time;
  final String status;

  CallLogItem(
      {this.name, this.initialLetter, this.date, this.time, this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: ButtonTheme(
              padding: EdgeInsets.symmetric(horizontal: 10),
              minWidth: 20,
              child: OutlineButton(
                child: Text('$initialLetter'),
                onPressed: () {},
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '$name',
                  style: kContactCallHistoryTextStyle,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: checkStatusIcon(status),
                    ),
                    Text(
                      '$date lúc $time',
                      style: kTimeCallHistoryTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            icon: ImageIcon(
              AssetImage(kPhoneButton),
              color: Pallete.primaryColor,
              size: 32,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  checkStatusIcon(String status) {
    if (status == 'outgoing') {
      return Icon(
        Icons.phone_forwarded,
        size: 14,
        color: Colors.yellow,
      );
    } else {
      if (status == 'missed') {
        return Icon(
          Icons.phone_missed,
          size: 14,
          color: Colors.red,
        );
      } else {
        return ImageIcon(
          AssetImage(kPhoneIncoming),
          size: 14,
          color: Colors.green,
        );
      }
    }
  }
}
