import 'package:flutter/material.dart';
import 'package:gcall/models/audioLog.dart';
import 'package:gcall/models/note.dart';
import 'package:gcall/models/reminder.dart';
import 'package:gcall/screens/ContactDetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:async/async.dart';

import '../widgets/ActivityHeaderWidget.dart';
import '../widgets/NoteItem.dart';
import '../widgets/ReminderItem.dart';
import '../widgets/PlayerItem.dart';

import '../providers/activities_provider.dart';

class ActivitiesScreen extends StatefulWidget {
  static const routeName = './activities_screen';
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  Future<void> _loadingActivities;
  ScrollController _scrollController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  AsyncMemoizer _memoizer = AsyncMemoizer();

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // TODO: update provider to get next activites
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final ContactDetailScreen args =
        ModalRoute.of(context).settings.arguments;
    _loadingActivities = _memoizer.runOnce(() {
      Provider.of<Activities>(
        context,
      ).fetchAndSetUpActivities(args.contactId, args.contactName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin Hoạt động'),
      ),
      body: FutureBuilder(
          future: _loadingActivities,
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                // TODO: Handling errors
                print(dataSnapshot.error);
                return Center(
                  child: Text('Got an error!'),
                );
              } else {
                return Consumer<Activities>(
                  builder: (context, activitiesData, _) => Column(
                    children: <Widget>[
                      ActivityHeaderWidget(),
                      Expanded(
                        child: SmartRefresher(
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
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            itemCount: activitiesData.activities.length,
                            itemBuilder: (context, index) {
                              // TODO: build widget by checking the activity type
                              if (activitiesData.activities[index] is Note) {
                                return NoteItem();
                              } else if (activitiesData.activities[index] is Reminder) {
                                return ReminderItem();
                              } else if (activitiesData.activities[index] is AudioLog) {
                                return PlayerItem();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }
}
