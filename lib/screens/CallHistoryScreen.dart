import 'package:flutter/material.dart';

import '../config/Pallete.dart' as Pallete;
import '../config/Constants.dart';

import '../widgets/CallHistoryWidget.dart';

class CallHistoryScreen extends StatefulWidget {
  static const routeName = './callhistory';
  @override
  _CallHistoryScreenState createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'LỊCH SỬ',
          style: kHeaderTextStyle,
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              Container(
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
                    Tab(child: Text('Tất cả')),
                    Tab(child: Text('Gọi đến')),
                    Tab(child: Text('Gọi đi')),
                    Tab(child: Text('Gọi nhỡ')),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    CallHistoryWidget(),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                    Icon(Icons.directions_bike),
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
