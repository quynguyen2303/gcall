import 'package:flutter/material.dart';

import 'ContactItem.dart';

class ContactWidget extends StatefulWidget {
  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  TextEditingController _editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

  void filterSearchResults() {
    var query = _editingController.text.toLowerCase();
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);

    // dummySearchList
    //     .where((contact) => contact.toLowerCase().contains(query.toLowerCase()))
    //     .toList();

    if (query.isNotEmpty) {
      List<String> dummyListData = dummySearchList
          .where(
              (contact) => contact.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
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
    items.addAll(duplicateItems);
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
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ContactItem(
                name: items[index],
                initialLetter: 'PQ',
              ),
            ),
          )
        ],
      ),
    );
  }
}
