import 'package:flutter/material.dart';
import 'package:gcall/widgets/ContactItem.dart';

import '../config/Constants.dart';

import '../widgets/ContactActivityWidget.dart';
import '../widgets/ContactDetailWidget.dart';


class ContactDetailScreen extends StatelessWidget {
  static const routeName = './contact_detail';

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
              // TODO: push to edit
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Flexible(flex: 1, child: ContactDetailWidget(id: args.id)),
            Flexible(flex: 1, child: ContactActivityWidget()),
          ],
        ),
      ),
    );
  }
}