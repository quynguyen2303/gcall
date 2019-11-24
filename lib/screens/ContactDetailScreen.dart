import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Constants.dart';

import 'UpdateContactScreen.dart';
import 'ActivitiesScreen.dart';

import '../widgets/ContactDetailWidget.dart';
import '../widgets/ContactItem.dart';

import '../providers/activities_provider.dart';

class ContactDetailScreen extends StatelessWidget {
  static const routeName = './contact_detail';

  final String contactId;
  final String contactName;

  ContactDetailScreen({this.contactId, this.contactName});

  @override
  Widget build(BuildContext context) {
    final ContactItem args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHI TIẾT LIÊN HỆ',
          style: kHeaderTextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Chỉnh sửa', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pushNamed(context, UpdateContactScreen.routeName,
                  arguments: ContactDetailScreen(contactId: args.contactId));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: ContactDetailWidget(
                args.contactId,
                args.contactName,
                args.initialLetter,
                args.contactPhone,
                args.contactEmail,
                args.contactGender,
              ),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Container(
                  child: RaisedButton(
                    child: Text('Lịch sử hoạt động'),
                    onPressed: () async {
                      var nav = await Navigator.of(context)
                          .pushNamed(ActivitiesScreen.routeName,
                              arguments: ContactDetailScreen(
                                contactId: args.contactId,
                                contactName: args.contactName,
                              ));
                      if (nav == null) {
                        // print('Nav is $nav');
                        Provider.of<Activities>(context, listen: false)
                            .clearActivities();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
