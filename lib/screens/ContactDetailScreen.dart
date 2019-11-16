import 'package:flutter/material.dart';

import '../config/Constants.dart';

import 'UpdateContactScreen.dart';

import '../widgets/ContactActivityWidget.dart';
import '../widgets/ContactDetailWidget.dart';
import '../widgets/ContactItem.dart';

class ContactDetailScreen extends StatelessWidget {
  static const routeName = './contact_detail';

  final String contactId;

  ContactDetailScreen({this.contactId});

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
              child: ContactActivityWidget(
                args.contactId,
                args.contactName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
