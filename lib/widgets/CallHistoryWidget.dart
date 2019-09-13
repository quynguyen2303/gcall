import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Styles.dart';
import '../config/Pallete.dart' as Pallete;

import '../providers/call_logs_provider.dart';

class CallHistoryWidget extends StatefulWidget {
  @override
  _CallHistoryWidgetState createState() => _CallHistoryWidgetState();
}

class _CallHistoryWidgetState extends State<CallHistoryWidget> {
  int pageNumber;
  ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        pageNumber += 1;
        print('Got the bootom and the page is $pageNumber');
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('Got the top');
    }
  }

  @override
  void initState() {
    pageNumber = 1;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final callLogs = Provider.of<CallLogs>(context);
    callLogs.fetchAndSetCallLogs(pageNumber);

    return ListView.builder(
        controller: _scrollController,
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
