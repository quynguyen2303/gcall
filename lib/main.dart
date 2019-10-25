import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'providers/auth_provider.dart';
import 'providers/call_logs_provider.dart';
import 'providers/contacts_provider.dart';
import 'providers/local_contacts_provider.dart';
import 'providers/info_provider.dart';

import 'screens/LoginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/CallHistoryScreen.dart';
import 'screens/SplashScreen.dart';
import 'screens/ContactsScreen.dart';
import 'screens/InformationScreen.dart';
import 'screens/CreateContactScreen.dart';
import 'screens/ContactDetailScreen.dart';
import 'screens/UpdateContactScreen.dart';
import 'screens/ActivitiesScreen.dart';

import './config/Pallete.dart' as Pallete;

void main() => runApp(GCall());

class GCall extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, CallLogs>(
          builder: (context, auth, previousCallLogs) => CallLogs(auth.token),
        ),
        ChangeNotifierProxyProvider<Auth, Contacts>(
          builder: (context, auth, previousContacts) => Contacts(auth.token),
        ),
        ChangeNotifierProxyProvider<Auth, Info>(
            builder: (context, auth, previousInfo) => Info(auth.token)),
        ChangeNotifierProvider.value(
          value: LocalContacts(),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            primaryColor: Pallete.primaryColor,
            backgroundColor: Colors.white,
          ),
          home: auth.isAuth()
              ? HomeScreen()
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
            HomeScreen.routeName: (context) => HomeScreen(),
            CallHistoryScreen.routeName: (context) => CallHistoryScreen(),
            ContactsScreen.routeName: (context) => ContactsScreen(),
            InformationScreen.routeName: (context) => InformationScreen(),
            CreateContactScreen.routeName: (context) => CreateContactScreen(),
            ContactDetailScreen.routeName: (context) => ContactDetailScreen(),
            ActivitiesScreen.routeName: (context) => ActivitiesScreen(),
            // UpdateContactScreen.routeName: (context) => UpdateContactScreen(),
          },
          onGenerateRoute: (settings) {
            // If push to UpdateContactScree
            if (settings.name == UpdateContactScreen.routeName) {
              final ContactDetailScreen args = settings.arguments;
              return MaterialPageRoute(builder: (context) {
                return UpdateContactScreen(id: args.id);
              });
            } 

            // test with popUntil 
            // if (settings.name == ContactsScreen.routeName) {
            //   return MaterialPageRoute(
            //     settings: RouteSettings(name: ContactsScreen.routeName),
            //     builder: (context) {
            //       return ContactsScreen();
            //     }
            //   );
            // }
          },
        ),
      ),
    );
  }
}
