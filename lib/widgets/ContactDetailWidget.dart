import 'package:flutter/material.dart';

import '../config/Constants.dart';
import '../config/Pallete.dart' as Pallete;


class ContactDetailWidget extends StatefulWidget {
  final String contactId;
  final String contactName;
  final String contactIni;
  final String contactPhone;
  final String contactEmail;
  final String contactGender;

  ContactDetailWidget(
    this.contactId,
    this.contactName,
    this.contactIni,
    this.contactPhone,
    this.contactEmail,
    this.contactGender,
  );

  @override
  _ContactDetailWidgetState createState() => _ContactDetailWidgetState();
}

class _ContactDetailWidgetState extends State<ContactDetailWidget> {
  // Future<void> _loadingContacts;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadingContacts = Provider.of<Contacts>(context, listen: false)
  //       .getOneContact(widget.contactId);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Flexible(
            flex: 3,
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
                  widget.contactIni,
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
              widget.contactName,
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
                  icon: kPhoneButton,
                  onPressed: () {},
                ),
                LabeledButton(
                  title: 'Ghi chú',
                  icon: kNoteAdd,
                  onPressed: () {},
                ),
                LabeledButton(
                  title: 'Nhắc nhở',
                  icon: kReminder,
                  onPressed: () {},
                ),
              ],
            ),
              ],
            ),
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
                          text: 'Email               :  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                        TextSpan(
                          text: widget.contactEmail == null
                              ? 'Không có'
                              : widget.contactEmail,
                          style: DefaultTextStyle.of(context).style,
                        )
                      ])),
                  // Divider(
                  //   color: Colors.white,
                  // ),
                  RichText(
                      text: TextSpan(
                          text: 'Điện thoại       :  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                        TextSpan(
                          text: widget.contactPhone,
                          style: DefaultTextStyle.of(context).style,
                        )
                      ])),
                  // Divider(
                  //   color: Colors.white,
                  // ),
                  RichText(
                      text: TextSpan(
                          text: 'Giới tính          :   ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          children: [
                        TextSpan(
                          text: widget.contactGender,
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
