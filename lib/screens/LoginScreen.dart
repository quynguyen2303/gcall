import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/Pallete.dart' as Pallete;

import '../providers/auth_provider.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = './login';

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: <Widget>[
                    Text(
                      'ĐĂNG NHẬP',
                      style: TextStyle(
                        color: Pallete.primaryColor,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    AuthCard(),
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
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final _userPasswordController = TextEditingController();

  bool _passwordSecure;
  bool _isLoading;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      // inputs are not valid
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_authData);
    try {
      await Provider.of<Auth>(context)
          .authenticate(_authData['email'], _authData['password']);

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      final alertMess = 'Email hoặc mật khẩu không đúng. Vui lòng thử lại!';
      _showErrorMess(alertMess);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorMess(message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Lỗi Đăng Nhập!'),
              content: Text(message),
              actions: <Widget>[
                RaisedButton(
                  color: Pallete.primaryColor,
                  child: Text(
                    'Thử Lại',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  void initState() {
    _passwordSecure = true;
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // ListView(
          //   shrinkWrap: true,
          //   scrollDirection: Axis.vertical,
          //   children: <Widget>[
          //     T
          //   ],
          // )
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              // set the validate rules for email
              if (value.isEmpty || !value.contains('@')) {
                return 'Email không chính xác!';
              }
              return null;
            },
            onSaved: (value) {
              _authData['email'] = value;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: _userPasswordController,
            obscureText: _passwordSecure, //This will obscure text dynamically
            validator: (value) {
              if (value.isEmpty || value.length < 6) {
                return 'Password is too short!';
              }
              return null;
            },
            onSaved: (value) {
              _authData['password'] = value;
            },
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              // Here is key idea
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordSecure ? Icons.visibility_off : Icons.visibility,
                  //  color: Theme.of(context).primaryColorDark,
                  size: 20,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordSecure = !_passwordSecure;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (_isLoading)
            CircularProgressIndicator()
          else
            ButtonTheme(
              buttonColor: Pallete.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minWidth: 300.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: _submit,
                child: Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          FlatButton(
            onPressed: () {},
            child: Text('Quên mật khẩu?'),
          )
        ],
      ),
    );
  }
}
