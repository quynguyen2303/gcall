import 'package:flutter/material.dart';

import '../config/Pallete.dart' as Pallete;
import '../config/Constants.dart';

import '../screens/NoteScreen.dart';

class ActivityHeaderWidget extends StatelessWidget {
  final String idContact;

  ActivityHeaderWidget(this.idContact);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,
          // shape: BoxShape.rectangle,
          // border: BorderDirectional(bottom: BorderSide(width: 1.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
            ),
          ]),
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LabeledButton(
            title: 'Gọi',
            icon: kPhoneButton,
            onPressed: () {},
          ),
          LabeledButton(
            title: 'Ghi chú',
            icon: kNoteAdd,
            onPressed: () {
              Navigator.pushNamed(
                context,
                NoteScreen.routeName,
                arguments: ActivityHeaderWidget(this.idContact),
              );
            },
          ),
          LabeledButton(
            title: 'Nhắc nhở',
            icon: kReminder,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class LabeledButton extends StatelessWidget {
  final String title;
  final String icon;
  final Function onPressed;

  LabeledButton({this.title, this.icon, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(children: [
        FlatButton(
          onPressed: onPressed,
          shape: CircleBorder(
              // side: BorderSide(
              //   width: 1.0,
              //   color: Pallete.primaryColor,
              // ),
              ),
          child: ImageIcon(
            AssetImage(icon),
            size: 40.0,
            color: Pallete.primaryColor,
          ),
        ),
        Text(title),
      ]),
    );
  }
}
