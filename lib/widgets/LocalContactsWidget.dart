import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactItem.dart';

// import '../models/contact.dart';

import '../providers/local_contacts_provider.dart';

class LocalContactWidget extends StatefulWidget {
  @override
  _LocalContactWidgetState createState() => _LocalContactWidgetState();
}

class _LocalContactWidgetState extends State<LocalContactWidget>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _editingController = TextEditingController();
  Timer timer;

  // List<Contact> _items;

  void fetchSearchContacts() async {
    final String query = _editingController.text;
    if (query.isNotEmpty) {
      Provider.of<LocalContacts>(context, listen: false).clearContacts();
      Provider.of<LocalContacts>(context, listen: false)
          .fetchLocalContacts(query);
      // _items = Provider.of<LocalContacts>(context, listen: false).contacts;
    }
  }

  void queryContacts() async {
    print(_editingController.text);
    if (_editingController.text.isNotEmpty) {
      print(_editingController.text == '');
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
      timer = Timer(Duration(seconds: 1), fetchSearchContacts);
    } else {
      print(_editingController.text == '');
      Provider.of<LocalContacts>(context, listen: false).clearContacts();
      // pageNumber = 1;
      await Provider.of<LocalContacts>(context, listen: false).fetchLocalContacts();
      // _items = Provider.of<LocalContacts>(context, listen: false).contacts;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _loadingContacts =
    //     Provider.of<LocalContacts>(context, listen: false).getPermission();
    // _items = Provider.of<LocalContacts>(context, listen: false).contacts;
    _editingController.addListener(queryContacts);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _editingController,
              decoration: InputDecoration(
                  hintText: "Tìm nhanh...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<LocalContacts>(context, listen: false)
                  .fetchLocalContacts(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    // Hanlding the error
                    print(dataSnapshot.error);
                    return Center(
                      child: Text('Got an error!'),
                    );
                  } else {
                    return Consumer<LocalContacts>(
                      builder: (context, localContacts, _) => ListView.builder(
                        itemCount: localContacts.contacts.length,
                        itemBuilder: (context, index) => ContactItem(
                          id: '', // TODO: fix this
                          name: localContacts.contacts[index].displayName,
                          initialLetter: localContacts.contacts[index].initials(),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
