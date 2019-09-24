import 'package:flutter/material.dart';

import '../config/Pallete.dart' as Pallete;
import '../config/Constants.dart';

class ContactItem extends StatelessWidget {
  final String initialLetter;
  final String name;

  ContactItem({this.initialLetter, this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: ButtonTheme(
              padding: EdgeInsets.symmetric(horizontal: 10),
              minWidth: 20,
              child: OutlineButton(
                child: Text('$initialLetter'),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: Text(
              '$name',
              style: kContactNameTextStyle,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
