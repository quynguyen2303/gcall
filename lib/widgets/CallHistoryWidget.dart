import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'CallLogItem.dart';

import '../providers/call_logs_provider.dart';

class CallHistoryWidget extends StatefulWidget {
  final String filter;

  CallHistoryWidget(this.filter);

  @override
  _CallHistoryWidgetState createState() => _CallHistoryWidgetState();
}

class _CallHistoryWidgetState extends State<CallHistoryWidget>
    with AutomaticKeepAliveClientMixin {
  String filter;

  ScrollController _scrollController;
  Future<void> _loadingCallLogs;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
   
      await Provider.of<CallLogs>(context, listen: false)
          .loadingMoreCallLogs(filter);

     
    }

  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // _isLoading = false;
    filter = widget.filter;
    // pageNumber = 1;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadingCallLogs = Provider.of<CallLogs>(context, listen: false)
        .fetchAndSetCallLogs(filter);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final callLogs = Provider.of<CallLogs>(context);
    // callLogs.fetchAndSetCallLogs(pageNumber);
    // final filter = widget.filter;
    // print('CallHistoryWidger filter is $filter');

    return FutureBuilder(
      future: _loadingCallLogs,
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
              builder: (context, callLogsData, child) => SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: _refreshController,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  _refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await Future.delayed(Duration(seconds: 1));
                  _refreshController.refreshCompleted();
                },
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: callLogsData.getCallLogs(filter).length,
                  itemBuilder: (context, index) => CallLogItem(
                      name: callLogsData.getCallLogs(filter)[index].name,
                      initialLetter:
                          callLogsData.getCallLogs(filter)[index].initialLetter,
                      date: callLogsData.getCallLogs(filter)[index].dateCreated,
                      time: callLogsData.getCallLogs(filter)[index].timeCreated,
                      status:
                          callLogsData.getCallLogs(filter)[index].statusString),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
