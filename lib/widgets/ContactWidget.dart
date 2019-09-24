import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ContactItem.dart';

import '../providers/contacts_provider.dart';

class ContactWidget extends StatefulWidget {
  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget>
    with AutomaticKeepAliveClientMixin {
  int pageNumber = 1;
  Future<void> _loadingContacts;

  TextEditingController _editingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  // final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  // var items = List<String>();

  // Local Search & Filter
  // void filterSearchResults() {
  //   var query = _editingController.text.toLowerCase();
  //   List<String> dummySearchList = List<String>();
  //   dummySearchList.addAll(duplicateItems);

  //   // dummySearchList
  //   //     .where((contact) => contact.toLowerCase().contains(query.toLowerCase()))
  //   //     .toList();

    // if (query.isNotEmpty) {
  //     List<String> dummyListData = dummySearchList
  //         .where(
  //             (contact) => contact.toLowerCase().contains(query.toLowerCase()))
  //         .toList();

  //     setState(() {
  //       items.clear();
  //       items.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       items.clear();
  //       items.addAll(duplicateItems);
  //     });
  //   }
  // }

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

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadingContacts = Provider.of<Contacts>(context, listen: false)
        .fetchAndSetUpContacts(pageNumber);
    // items.addAll(duplicateItems);
    // _editingController.addListener(filterSearchResults);
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
                      child: Text('Got an error!'),
                    );
                  } else {
                    return Consumer<Contacts>(
                      builder: (context, contactsData, child) =>
                          ListView.builder(
                            controller: _scrollController,
                        itemCount: contactsData.contacts.length,
                        itemBuilder: (context, index) => ContactItem(
                          name: contactsData.contacts[index].displayName,
                          initialLetter:
                              contactsData.contacts[index].initials(),
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
