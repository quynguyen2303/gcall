import 'package:flutter/material.dart';

import '../config/Constants.dart';
import '../config/Pallete.dart' as Pallete;

class ContactDetailHeaderWidget extends StatelessWidget {
  final String id;

  ContactDetailHeaderWidget({this.id});

  @override
  Widget build(BuildContext context) {
    print(id);
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ButtonTheme(
          padding: EdgeInsets.symmetric(horizontal: 10),
          minWidth: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: OutlineButton(
            child: Text('PQ'),
            onPressed: () {},
          ),
        ),
        Text('Phu Quy'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LabeledButton(title: 'Gọi', icon: kPhoneIncoming, onPressed: () {},),
            LabeledButton(title: 'Ghi chú', icon: kNoteAdd, onPressed: () {},),
            LabeledButton(title: 'Nhắc nhở', icon: kAlarm, onPressed: () {},),
          ],
        )
      ],
    ));
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
            side: BorderSide(
              width: 1.0,
              color: Pallete.primaryColor,
            ),
            
          ),
          child: ImageIcon(AssetImage(icon), color: Pallete.primaryColor,),
        ),
        Text(title),
      ]),
    );
  }
}
