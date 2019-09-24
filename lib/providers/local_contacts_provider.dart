import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

import '../models/contact.dart' as Model;

class LocalContacts extends ChangeNotifier {
  List<Model.Contact> _contacts = [];

  List<Model.Contact> get contacts {
    return _contacts;
  }

 

  Future<void> getPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions;

    permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.contacts]);

    if (permissions[PermissionGroup.contacts] == PermissionStatus.granted) {
      Iterable<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);
      contacts.forEach(
        (c) {
          final String firstName =
              c.givenName?.isNotEmpty == true ? c.givenName : '';
          final String lastName =
              c.familyName?.isNotEmpty == true ? c.familyName : '';
          final List phones = c.phones.toList();
          final String phone = phones.length > 0 ? phones[0].value : '';
          // print(firstName + ' ' + lastName + ' ' + phone);
          if (firstName != '' || lastName != '') {
            final newContact = Model.Contact(
                firstName: firstName, lastName: lastName, phone: phone);
            _contacts.add(newContact);
          }
        },
      );
    }
  }
}
