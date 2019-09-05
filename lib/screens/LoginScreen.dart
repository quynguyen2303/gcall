import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // SizedBox(
                //   height: 10,
                // ),
                // Dang Nhap Box
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('Đăng Nhập'),
                      Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                            ),
                            RaisedButton(
                              // color: Colors.purple,
                              onPressed: () {},
                              child: Text('Đăng Nhập'),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(' Quên mật khẩ u?'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Footer
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('@2019 Gcall, Inc. All Rights Reserved.'),
                    Text('Privacy Policy'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
