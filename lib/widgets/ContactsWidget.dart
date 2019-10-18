import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactItem.dart';

import '../providers/contacts_provider.dart';

/// A Widget contains a list of contact item

class ContactWidget extends StatefulWidget {
  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget>
    with AutomaticKeepAliveClientMixin {
  int pageNumber = 1;
  Timer timer;

  TextEditingController _editingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(
        () {
          // _isLoading = true;
          pageNumber += 1;
          Provider.of<Contacts>(context, listen: false)
              .fetchAndSetUpContacts(pageNumber);
        },
      );
    }
  }

  void fetchSearchContacts() {
    final String query = _editingController.text;
    if (query.isNotEmpty) {
      Provider.of<Contacts>(context, listen: false).searchContacts(query);
    }
  }

  void queryContacts() {
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
      Provider.of<Contacts>(context, listen: false).clearContacts();
      pageNumber = 1;
      Provider.of<Contacts>(context, listen: false)
          .fetchAndSetUpContacts(pageNumber);
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
    // _loadingContacts = Provider.of<Contacts>(context, listen: false)
    //     .fetchAndSetUpContacts(pageNumber);
    _editingController.addListener(queryContacts);
    _scrollController.addListener(_scrollListener);
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
              future: Provider.of<Contacts>(context, listen: false)
                  .fetchAndSetUpContacts(pageNumber),
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
                      // TODO: change to more explanable test
                      child: Text('Got an error!'),
                    );
                  } else {
                    return Consumer<Contacts>(
                      builder: (context, contactsData, child) =>
                          ListView.builder(
                        controller: _scrollController,
                        itemCount: contactsData.contacts.length,
                        itemBuilder: (context, index) => ContactItem(
                          id: contactsData.contacts[index].id,
                          name: contactsData.contacts[index].displayName,
                          initialLetter:
                              contactsData.contacts[index].initials,
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
