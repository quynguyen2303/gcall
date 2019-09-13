import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class CallLogs extends ChangeNotifier {
  final String _token;
  List callLogs;

  String url = 'https://mobile-docker.gcall.vn/calllogs';

  final testToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZENhbGxjZW50ZXIiOiJqZ2xOYkJoQHVEIiwiaWRVc2VyIjoiNWI1NWYyOTVhMjBmNDI4NDM1MDk4YmJiIiwiZW1haWwiOiJ0aGVoaWVuMTE1QGdtYWlsLmNvbSIsImZ1bGxOYW1lIjoidGhlaGllbjExNSIsImNyZWF0ZWRBdCI6IjIwMTktMDktMTNUMDI6Mjc6MjUuMzQ5WiIsImlhdCI6MTU2ODM0MTY0NX0.yaX9rpWaiXW7M19yKB7Qvw5kog45DnwfmJgM6lF8TDQ';

  CallLogs(this._token);

  Future<void> fetchAndSetCallLogs(int pageNumber, [String filter = '']) async {
    // Call API and get the first page of Call Logs

    // Set up header with _token
    var dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = testToken;
    }));
    print('Page number in provider is $pageNumber');

    try {
      Response response = await dio.get(url, queryParameters: {
        'page': pageNumber,
        'filter': '{"direction": "incoming"}' ,
      });

      if (callLogs == null) {
        callLogs = response.data['result'];
      } else {
        callLogs.addAll(response.data['result']);
      }
      print(callLogs.length);
      for (var i = 0; i < callLogs.length; i++) {
        print(callLogs[i]);
      }
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

    // print(callLogs);
    // print(callLogs[1]['_id']+ " & contact id: " + callLogs[1]['contact']['_id']);
    // print(callLogs[2]['_id']+ " & contact id: " + callLogs[2]['contact']['_id']);
  }
}
