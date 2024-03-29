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

  String _contactId;
  String _contactName;

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_contactId != null && _contactName != null) {
        Provider.of<Activities>(context, listen: false)
            .loadingMoreContacts(_contactId, _contactName);
      }
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
    final ContactDetailScreen args = ModalRoute.of(context).settings.arguments;
    _contactId = args.contactId;
    _contactName = args.contactName;

    _loadingActivities = _memoizer.runOnce(() {
      Provider.of<Activities>(context, listen: false)
          .fetchAndSetUpActivities(_contactId, _contactName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin Hoạt động'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<Activities>(context, listen: false).clearActivities();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          ActivityHeaderWidget(args.contactId),
          Container(
            child: Expanded(
              child: FutureBuilder(
                  future: _loadingActivities,
                  builder: (context, dataSnapshot) {
                    // print(dataSnapshot.connectionState);
                    if (dataSnapshot.connectionState == ConnectionState.waiting) {
                      // print('Inside watiting...');
                      // TODO: cannot render this widget when waiting !!!
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
                          builder: (context, activitiesData, _) => SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            controller: _refreshController,
                            onRefresh: () async {
                              Provider.of<Activities>(context, listen: false)
                                  .clearActivities();
                              await Provider.of<Activities>(context,
                                      listen: false)
                                  .fetchAndSetUpActivities(
                                      _contactId, _contactName);
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
                                if (activitiesData.activities[index] is Note) {
                                  Note _newNote =
                                      activitiesData.activities[index];
                                  return NoteItem(
                                    idNote: _newNote.idNote,
                                    idContact: _newNote.idContact,
                                    contactName: _newNote.contactName,
                                    noteText: _newNote.noteText,
                                    date: _newNote.date,
                                  );
                                } else if (activitiesData.activities[index]
                                    is Reminder) {
                                  Reminder _newReminder =
                                      activitiesData.activities[index];
                                  return ReminderItem(
                                    idReminder: _newReminder.idReminder,
                                    contactName: _newReminder.contactName,
                                    receiverName: _newReminder.receiverName,
                                    reminderText: _newReminder.reminderText,
                                    createdAt: _newReminder.date,
                                    remindAt: _newReminder.remindWhen,
                                  );
                                } else if (activitiesData.activities[index]
                                    is AudioLog) {
                                  AudioLog _newAudioLog =
                                      activitiesData.activities[index];
                                  return PlayerItem(
                                    idAudioLog: _newAudioLog.idAudioLog,
                                    contactName: _newAudioLog.contactName,
                                    url: _newAudioLog.url,
                                    createdAt: _newAudioLog.date,
                                    duration: _newAudioLog.durationText,
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      }
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
