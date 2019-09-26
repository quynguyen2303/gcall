import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactItem.dart';

import '../models/contact.dart';

import '../providers/local_contacts_provider.dart';

class LocalContactWidget extends StatefulWidget {
  @override
  _LocalContactWidgetState createState() => _LocalContactWidgetState();
}

class _LocalContactWidgetState extends State<LocalContactWidget> with AutomaticKeepAliveClientMixin {
  TextEditingController _editingController = TextEditingController();

  Future<void> _loadingContacts;
  List<Contact> _items;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // _editingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadingContacts =
        Provider.of<LocalContacts>(context, listen: false).getPermission();
    _items = Provider.of<LocalContacts>(context, listen: false).contacts;

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
              future: _loadingContacts,
              builder: (context, dataSnapshot)  {
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
                    return ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) => ContactItem(
                        name: _items[index].displayName,
                        initialLetter: _items[index].initials(),
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
