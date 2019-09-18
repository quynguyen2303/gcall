import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Constants.dart';
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
    // final callLogs = Provider.of<CallLogs>(context);
    // callLogs.fetchAndSetCallLogs(pageNumber);

    return FutureBuilder(
      future: Provider.of<CallLogs>(context).fetchAndSetCallLogs(pageNumber),
      builder: (context, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error != null) {
            // Hanlding the error
            print(dataSnapshot.error);
            return Center(
              child: Text('Got an error!'),
            );
          } else {
            return Consumer<CallLogs>(
              builder: (context, callLogsData, child) => ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: callLogsData.callLogs.length,
                itemBuilder: (context, index) => CallLogItem(
                    name: callLogsData.callLogs[index].name,
                    initialLetter: callLogsData.callLogs[index].initialLetter,
                    date: callLogsData.callLogs[index].dateCreated,
                    time: callLogsData.callLogs[index].timeCreated,
                    status: callLogsData.callLogs[index].statusString),
              ),
            );
          }
        }
      },
    );
  }
}

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
          Column(
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
