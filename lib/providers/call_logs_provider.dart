import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

enum CallStatus { outgoing, incoming, missed }

class CallLogs extends ChangeNotifier {
  final String _token;
  List<CallLog> callLogs = [];

  String url = 'https://mobile-docker.gcall.vn/calllogs';

  CallLogs(this._token);

  Future<void> fetchAndSetCallLogs(int pageNumber, [String filter = '']) async {
    // Call API and get the first page of Call Logs

    // Set up header with _token
    var dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = _token;
    }));
    print('Page number in provider is $pageNumber');

    try {
      Response response = await dio.get(url, queryParameters: {
        'page': pageNumber,
        // 'filter': '{"direction": "incoming"}' ,
      });
      // print(response.data['result']);
      response.data['result'].forEach((e) {
        var firstName = e['contact']['firstName'];
        var lastName = e['contact']['lastName'];
        var startedAt = DateTime.fromMillisecondsSinceEpoch(e['createdAt']);
        var status = checkCallLogStatus(e['direction'], e['status']);
        var twoLetter = getInitialLetter(firstName, lastName);
        // print(firstName + lastName + startedAt.toString() + direction + status);
        // });

        callLogs.add(
          CallLog(
              name: '$firstName $lastName',
              initialLetter: twoLetter,
              status: status,
              dateCreated:
                  '${startedAt.day}/${startedAt.month}',
              timeCreated: '${startedAt.hour}:${startedAt.minute}',),
        );
      });

      print(callLogs.length);
      for (var i = 0; i < callLogs.length; i++) {
        print(callLogs[i]);
      }
      // for (var i = 0; i < response.data['result'].length; i++) {
      //   print(response.data['result'][i]);}

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

  checkCallLogStatus(e, e2) {
    //To-Do: Implement check status
    return CallStatus.incoming;
  }

  getInitialLetter(firstName, lastName) {
    return 'PQ';
  }
}

class CallLog {
  String name;
  String initialLetter;
  CallStatus status;
  String dateCreated;
  String timeCreated;
  // DateTime startedTime;

  CallLog({this.name, this.initialLetter, this.status, this.dateCreated, this.timeCreated});
  
  @override
  String toString() {
    // TODO: implement toString
    return 'The call log from $name at $dateCreated at $timeCreated and the status is $status';
  }
}
