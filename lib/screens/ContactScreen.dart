import 'package:flutter/material.dart';

import '../config/Constants.dart';
import '../config/Pallete.dart' as Pallete;

import '../widgets/ContactWidget.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = './contact';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'DANH BẠ',
          style: kHeaderTextStyle,
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: 200,
                // padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Pallete.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  // indicatorColor: Colors.white,
                  // indicatorWeight: 0.1,
                  indicator: BoxDecoration(
                      color: Pallete.primaryColor,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  labelColor: Colors.white,
                  unselectedLabelColor: Pallete.primaryColor,

                  // labelPadding: EdgeInsets.symmetric(horizontal: 20),
                  tabs: <Widget>[
                    Tab(child: Text('Cá Nhân')),
                    Tab(child: Text('Hệ thống')),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ContactWidget(),
                    ContactWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
