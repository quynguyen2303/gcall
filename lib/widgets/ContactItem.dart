import 'package:flutter/material.dart';

// import '../config/Pallete.dart' as Pallete;
import '../config/Constants.dart';

import '../screens/ContactDetailScreen.dart';

class ContactItem extends StatelessWidget {
  final String initialLetter;
  final String contactName;
  final String contactId;
  final String contactPhone;
  final String contactEmail;
  final String contactGender;

  ContactItem({
    @required this.contactId,
    this.initialLetter,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.contactGender,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () async {
          // try to get reload after navigator pop
          await Navigator.of(context).pushNamed(
            ContactDetailScreen.routeName,
            arguments: ContactItem(
              contactId: this.contactId,
              contactName: this.contactName,
              initialLetter: this.initialLetter,
              contactEmail: this.contactEmail,
              contactPhone: this.contactPhone,
              contactGender: this.contactGender,
            ),
          );
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
                '$contactName',
                style: kContactNameTextStyle,
              ),
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
