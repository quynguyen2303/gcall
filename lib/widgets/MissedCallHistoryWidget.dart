import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CallLogItem.dart';

import '../providers/call_logs_provider.dart';

class MissedCallHistoryWidget extends StatefulWidget {
  final String filter;

  MissedCallHistoryWidget({this.filter});

  @override
  _MissedCallHistoryWidgetState createState() => _MissedCallHistoryWidgetState();
}

class _MissedCallHistoryWidgetState extends State<MissedCallHistoryWidget> {
  int pageNumber;
  ScrollController _scrollController;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        pageNumber += 1;
      });

      // print('Got the bootom and the page is $pageNumber');
    }
    // if (_scrollController.offset <=
    //         _scrollController.position.minScrollExtent &&
    //     !_scrollController.position.outOfRange) {
    //   // print('Got the top');
    // }
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
    // final filter = widget.filter;
    // print('CallHistoryWidger filter is $filter');
    final filter = 'missed';

    return FutureBuilder(
      future: Provider.of<CallLogs>(context)
          .fetchAndSetCallLogs(pageNumber, filter),
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
                itemCount: callLogsData.missedCallLogs.length,
                itemBuilder: (context, index) => CallLogItem(
                    name: callLogsData.missedCallLogs[index].name,
                    initialLetter: callLogsData.missedCallLogs[index].initialLetter,
                    date: callLogsData.missedCallLogs[index].dateCreated,
                    time: callLogsData.missedCallLogs[index].timeCreated,
                    status: callLogsData.missedCallLogs[index].statusString),
              ),
            );
          }
        }
      },
    );
  }
}
