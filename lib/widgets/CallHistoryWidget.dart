import 'package:flutter/material.dart';

import '../config/Styles.dart';
import '../config/Pallete.dart' as Pallete;

//  List<Map> _callHistoryList = [
//   {
//     'initial': 'AP',
//     'name': 'Thiên Đặng',

//   },
//   {}
// ];

class CallHistoryWidget extends StatefulWidget {
  @override
  _CallHistoryWidgetState createState() => _CallHistoryWidgetState();
}

class _CallHistoryWidgetState extends State<CallHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
              child: Row(mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: ButtonTheme(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    minWidth: 20,
                    child: OutlineButton(
                      child: Text('AP'),
                      onPressed: () {},
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Thien Dang',
                      style: kContactCallHistoryTextStyle,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.phone_missed,
                              size: 14,
                              color: Colors.red,
                            )),
                        Text(
                          '4/11 luc 14:11',
                          style: kTimeCallHistoryTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/icons/call-button.png'),
                    color: Pallete.primaryColor,
                    size: 32,
                  ),
                  onPressed: () {},
                )
              ]));
        });
  }
}
