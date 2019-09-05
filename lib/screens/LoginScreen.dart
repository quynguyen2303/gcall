import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Dang Nhap Box
                Column(),
                // Footer
                Column(
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
