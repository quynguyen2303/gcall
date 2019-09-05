import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Dang Nhap Box
                Column(
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
                        ],
                      ),
                    ),
                  ],
                ),
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
