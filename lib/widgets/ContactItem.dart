import 'package:flutter/material.dart';

// import '../config/Pallete.dart' as Pallete;
import '../config/Constants.dart';

import '../screens/ContactDetailScreen.dart';

class ContactItem extends StatelessWidget {
  final String initialLetter;
  final String name;
  final String id;

  ContactItem({@required this.id, this.initialLetter, this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ContactDetailScreen.routeName,
              arguments: ContactItem(id: this.id));
        },
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
      ),
    );
  }
}
