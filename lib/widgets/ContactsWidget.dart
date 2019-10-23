import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'ContactItem.dart';

import '../providers/contacts_provider.dart';

/// A Widget contains a list of contact item

class ContactsWidget extends StatefulWidget {
  @override
  _ContactsWidgetState createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget>
    with AutomaticKeepAliveClientMixin {
  // int pageNumber = 1;
  Timer timer;

  TextEditingController _editingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _loadingContacts;

  void _scrollListener() async {
    // print('Scorll start...');
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _editingController.text.isEmpty) {
      
      await Provider.of<Contacts>(context, listen: false)
          .loadingMoreContacts();
    }
  }

  void fetchSearchContacts() async {
    final String query = _editingController.text;
    if (query.isNotEmpty) {
      await Provider.of<Contacts>(context, listen: false).searchContacts(query);
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
      Provider.of<Contacts>(context, listen: false).clearContacts();
      await Provider.of<Contacts>(context, listen: false)
          .fetchAndSetUpContacts();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _editingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _loadingContacts = Provider.of<Contacts>(context, listen: false)
    //     .fetchAndSetUpContacts(pageNumber);
    _editingController.addListener(queryContacts);
    _scrollController.addListener(_scrollListener);

    _loadingContacts = Provider.of<Contacts>(context, listen: false)
        .fetchAndSetUpContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // print(pageNumber);

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
                      builder: (context, contactsData, child) => SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: _refreshController,
                        onRefresh: () async {
                          await Future.delayed(Duration(seconds: 1));
                          _refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await Future.delayed(Duration(seconds: 1));
                          _refreshController.refreshCompleted();
                        },
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: contactsData.contacts.length,
                          itemBuilder: (context, index) => ContactItem(
                            id: contactsData.contacts[index].id,
                            name: contactsData.contacts[index].displayName,
                            initialLetter:
                                contactsData.contacts[index].initials,
                          ),
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
