import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

import 'package:gcall/screens/LoginScreen.dart';
import 'screens/HistoryScreen.dart';
import 'screens/SplashScreen.dart';

import './config/Pallete.dart' as Pallete;

void main() => runApp(GCall());

class GCall extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: Consumer<Auth>(builder: (context, auth, _) => MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: Pallete.primaryColor,
          backgroundColor: Colors.white,
        ),
        home: auth.isAuth()
              ? CallHistory()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          CallHistory.routeName: (context) => CallHistory(),

        },
      ),)  
      
    );
  }
}
