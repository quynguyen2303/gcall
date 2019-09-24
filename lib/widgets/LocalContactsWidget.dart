import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactItem.dart';

import '../models/contact.dart';

import '../providers/local_contacts_provider.dart';

class LocalContactWidget extends StatefulWidget {
  @override
  _LocalContactWidgetState createState() => _LocalContactWidgetState();
}

class _LocalContactWidgetState extends State<LocalContactWidget> {
  TextEditingController _editingController = TextEditingController();

  Future<void> _loadingContacts;
  List<Contact> _allItems;
  List<Contact> _items;

  // Quick Search
  void filterSearchResults() {
    var query = _editingController.text.toLowerCase();
    List<Contact> dummySearchList = [];

    
    dummySearchList =
        Provider.of<LocalContacts>(context, listen: false).contacts;

    // dummySearchList
    //     .where((contact) => contact.toLowerCase().contains(query.toLowerCase()))
    //     .toList();

    if (query.isNotEmpty) {
      List<Contact> dummyListData = dummySearchList
          .where((contact) =>
              contact.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        _items.clear();
        _items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _items.clear();
        _items.addAll(_allItems);
      });
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadingContacts =
        Provider.of<LocalContacts>(context, listen: false).getPermission();

    _items = Provider.of<LocalContacts>(context, listen: false).contacts;

    _editingController.addListener(filterSearchResults);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
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
