import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../models/activity.dart';
import '../config/Constants.dart';

class Activities extends ChangeNotifier {
  final String _token;
  // final String idContact;
  bool _isSetInterceptor = false;
  List<Activity> activities = [];

  Activities(
    this._token,
  );

  var dio = Dio();

  void _setUpDioWithHeader() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = _token;
    }));
    _isSetInterceptor = true;
  }

  Future<void> fetchAndSetUpActivities(String idContact, String contactName) async {
    final String url = kUrl + 'contact/$idContact/activities';
    if (!_isSetInterceptor) {
      _setUpDioWithHeader();
    }

    try {
      Response response = await dio.get(url);
      print(response.data['result'].length);
      response.data['result'].forEach(
        (activity) {
          if (activity['type'] == 'calllog') {
            // TODO
            activity['body']['recordUrl'];
          } else if (activity['type'] == 'note') {
            // TODO
          } else if (activity['type'] == 'reminder') {
            // TODO
          } else {
            print('The activity type is not correct!');
          }
        }
      );
      print(response.data['result']);
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
