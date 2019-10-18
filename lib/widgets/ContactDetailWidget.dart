import 'package:flutter/material.dart';

import '../config/Constants.dart';
import '../config/Pallete.dart' as Pallete;

class ContactDetailWidget extends StatelessWidget {
  final String id;

  ContactDetailWidget({this.id});

  @override
  Widget build(BuildContext context) {
    print(id);
    return Column(
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                // padding: EdgeInsets.symmetric(horizontal: 21),
                minWidth: 20,
                shape: CircleBorder(),
                child: OutlineButton(
                  padding: EdgeInsets.all(10.0),
                  // borderSide: BorderSide(color: Colors.black),
                  child: Text(
                    'PQ',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    return;
                  },
                ),
              ),
              Divider(
                color: Colors.white10,
                height: 10.0,
              ),
              Text(
                'Phu Quy',
                style: kHeaderTextStyle,
              ),
              Divider(
                color: Colors.white10,
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LabeledButton(
                    title: 'Gọi',
                    icon: kPhoneIncoming,
                    onPressed: () {},
                  ),
                  LabeledButton(
                    title: 'Ghi chú',
                    icon: kNoteAdd,
                    onPressed: () {},
                  ),
                  LabeledButton(
                    title: 'Nhắc nhở',
                    icon: kAlarm,
                    onPressed: () {},
                  ),
                ],
              )
            ],
          )),
        ),
        // Divider(color: Colors?.white10,),
        Flexible(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: 15.0, top: 0.0, bottom: 0.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black26),
                bottom: BorderSide(width: 1.0, color: Colors.black26),
              ),
              // borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                        text: 'Email               : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: [
                      TextSpan(
                        text: 'nguyenphuquy2303@gmail.com',
                        style: DefaultTextStyle.of(context).style,
                      )
                    ])),
                // Divider(
                //   color: Colors.white,
                // ),
                RichText(
                    text: TextSpan(
                        text: 'Điện thoại       : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: [
                      TextSpan(
                        text: 'nguyenphuquy2303@gmail.com',
                        style: DefaultTextStyle.of(context).style,
                      )
                    ])),
                // Divider(
                //   color: Colors.white,
                // ),
                RichText(
                    text: TextSpan(
                        text: 'Giới tính          : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        children: [
                      TextSpan(
                        text: 'nguyenphuquy2303@gmail.com',
                        style: DefaultTextStyle.of(context).style,
                      )
                    ]))
              ],
            ),
          ),
        ),
      ],
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
            side: BorderSide(
              width: 1.0,
              color: Pallete.primaryColor,
            ),
          ),
          child: ImageIcon(
            AssetImage(icon),
            color: Pallete.primaryColor,
          ),
        ),
        Text(title),
      ]),
    );
  }
}
