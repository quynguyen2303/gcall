import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CallLogItem.dart';

import '../providers/call_logs_provider.dart';

class OutgoingCallHistoryWidget extends StatefulWidget {
  final String filter;

  OutgoingCallHistoryWidget({this.filter});

  @override
  _OutgoingCallHistoryWidgetState createState() => _OutgoingCallHistoryWidgetState();
}

class _OutgoingCallHistoryWidgetState extends State<OutgoingCallHistoryWidget> {
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
    final filter = 'outgoing';

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
                itemCount: callLogsData.outgoingCallLogs.length,
                itemBuilder: (context, index) => CallLogItem(
                    name: callLogsData.outgoingCallLogs[index].name,
                    initialLetter: callLogsData.outgoingCallLogs[index].initialLetter,
                    date: callLogsData.outgoingCallLogs[index].dateCreated,
                    time: callLogsData.outgoingCallLogs[index].timeCreated,
                    status: callLogsData.outgoingCallLogs[index].statusString),
              ),
            );
          }
        }
      },
    );
  }
}
