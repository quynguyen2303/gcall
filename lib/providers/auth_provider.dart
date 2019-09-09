import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  // DateTime _expiryDate;

  bool isAuth() {
    print('Auto Auth');
    print(_token != null);
    return _token != null;
  }

  // String get token {
  //   if (_expiryDate != null &&
  //       _expiryDate.isAfter(DateTime.now()) &&
  //       _token != null) {
  //     return _token;
  //   } else {
  //     return null;
  //   }
  // }

  String get userId {
    return _userId;
  }

  Future<void> authenticate(String email, String password) async {
    final String url = 'https://mobile-docker.gcall.vn/signin';
    print('$email + $password');
    Dio dio = Dio();

    try {
      // authenticate from server
      print('Start Authenticate');
      final response = await dio.post(
        url,
        data: {'email': email, 'password': password},
      );
      print('Done Authenticate');
      // store the user data if success
      _token = response.data['result']['_id'];
      _userId = response.data['result']['idUser'];
      // _expiryDate = DateTime.now().add(
      //   Duration(hours: 72),
      // );
      // print(response.data['_id']);
      // print(response.data['idUser']);

      notifyListeners();
      // print(response.data);

      // Store user data locally for auto login
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print('After prefs');
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        // 'expiryDate': _expiryDate.toIso8601String(),
      });
      print('After userData');
      prefs.setString(
        'userData',
        userData,
      );
      print(userData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      if (e.response != null) {
        print('error data:');
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('error without data:');
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }

  Future<bool> tryAutoLogin() async {
    print('Run Auto Login');
    final prefs = await SharedPreferences.getInstance();
    print(prefs);
    if (!prefs.containsKey('userData')) {
      print('No prefs');
      return false;
    } else {
      final userData = prefs.getString('userData');
      final extractedUserData = json.decode(userData) as Map<String, Object>;
      // final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
      // if (expiryDate.isBefore(DateTime.now())) {
      //   return false;
      // } else {
      _token = extractedUserData['token'];
      _userId = extractedUserData['userId'];
      // _expiryDate = expiryDate;
      notifyListeners();
      // _autoLogout();

      return true;
    }
  }
}
