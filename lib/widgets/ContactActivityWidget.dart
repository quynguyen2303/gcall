import 'package:flutter/material.dart';

import '../screens/ActivitiesScreen.dart';

class ContactActivityWidget extends StatelessWidget {
  final String id;

  ContactActivityWidget(this.id);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text('Lịch sử hoạt động'),
          onPressed: () {
            Navigator.of(context).pushNamed(ActivitiesScreen.routeName,
                arguments: ContactActivityWidget(this.id));
          },
        ),
      ),
    );
  }
}
