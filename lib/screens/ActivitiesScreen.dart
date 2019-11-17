import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widgets/ContactActivityWidget.dart';
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
  @override
  Widget build(BuildContext context) {
    final ContactActivityWidget args = ModalRoute.of(context).settings.arguments;
    Provider.of<Activities>(context, listen: false).fetchAndSetUpActivities(args.contactId, args.contactName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin Hoạt động'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ActivityHeaderWidget(),
            Flexible(
              child: ListView(
                children: <Widget>[
                  NoteItem(),
                  ReminderItem(),
                  PlayerWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
