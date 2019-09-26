import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../config/Constants.dart';

class Info extends ChangeNotifier {
  final String _token;
  String name;
  String email;
  String phone;

  final String url = kUrl + 'session';
  var dio = Dio();

  Info(this._token);

  void setUpDioWithHeader() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = _token;
    }));
  }

  Future<void> fetchUserInfo() async {
    setUpDioWithHeader();

    try {
      Response response = await dio.get(
        url,
      );
      print(response.data);
      name = response.data['result']['fullName'];
      email = response.data['result']['email'];
      phone = response.data['result']['idCallcenter'];

  
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
}
