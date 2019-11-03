import 'package:flutter/material.dart';

import '../widgets/ActivityHeaderWidget.dart';
import '../widgets/NoteItem.dart';
import '../widgets/ReminderItem.dart';

class ActivitiesScreen extends StatefulWidget {
  static const routeName = './activities_screen';
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
