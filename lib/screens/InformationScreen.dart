import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Constants.dart';
// import '../config/Pallete.dart' as Pallete;

import '../providers/info_provider.dart';

class InformationScreen extends StatefulWidget {
  static const routeName = './info';

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  bool _incomingCall = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var infoData = Provider.of<Info>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'THÔNG TIN CÁ NHÂN',
          style: kHeaderTextStyle,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(kBanner), fit: BoxFit.cover),
              ),
              // child: Text('This is a banner'),
            ),
          ),
          FutureBuilder(
            future: Provider.of<Info>(context).fetchUserInfo(),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  flex: 3,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (dataSnapshot.error != null) {
                  // Hanlding the error
                  print(dataSnapshot.error);
                  return Center(
                    child: Text('Got an error!'),
                  );
                } else {
                  return Consumer<Info>(
                    builder: (context, infoData, child) => Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          children: <Widget>[
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.contacts),
                                title: Text(infoData.name),
                                trailing: IconButton(
                                  icon: Icon(Icons.navigate_next),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.mail),
                                title: Text(infoData.email),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.phone),
                                title: Text(infoData.phone),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                leading: Icon(Icons.lock),
                                title: Text('Đổi Mật Khẩu'),
                                trailing: IconButton(
                                  icon: Icon(Icons.navigate_next),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Card(
                              child: SwitchListTile(
                                secondary: Icon(Icons.phone_in_talk),
                                title: Text('Tiếp nhận cuộc gọi'),
                                value: _incomingCall,
                                onChanged: (bool value) {
                                  setState(() {
                                    _incomingCall = value;
                                  });
                                },
                              ),
                            ),
                            Spacer(),
                            ButtonTheme(
                              buttonColor: Colors.white,
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(20)),
                              minWidth: 300.0,
                              height: 50.0,
                              child: RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  'ĐĂNG XUẤT',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
