import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

enum CallStatus { outgoing, incoming, missed }

class CallLogs extends ChangeNotifier {
  final String _token;
  String stringFilter;
  List<CallLog> _allCallLogs = [];
  List<CallLog> _incomingCallLogs = [];
  List<CallLog> _outgoingCallLogs = [];

  List<CallLog> _missedCallLogs = [];

  var dio = Dio();

  String url = 'https://mobile-docker.gcall.vn/calllogs';

  CallLogs(this._token);

  List<CallLog> get allCallLogs {
    return _allCallLogs;
  }

  List<CallLog> get incomingCallLogs {
    return _incomingCallLogs;
  }

  List<CallLog> get outgoingCallLogs {
    return _outgoingCallLogs;
  }

  List<CallLog> get missedCallLogs {
    return _missedCallLogs;
  }

  // Set up Dio with header
  void setUpDioWithHeader() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = _token;
    }));
  }

  void setFilter(String filter) {
    if (filter == 'incoming') {
      stringFilter =
          '{"direction": "incoming" , "status": { "\$ne" : "missed" } }';
    } else if (filter == 'outgoing') {
      stringFilter = '{ "direction": "outgoing" } ';
    } else if (filter == 'missed') {
      stringFilter = '{ "status": "missed" } ';
    } else {
      stringFilter = '';
    }

    //  }
    // 'filter':  ,
    // 'filter':  ,
  }

  Future<void> fetchAndSetCallLogs(int pageNumber, [String filter = '']) async {
    // Set up Call Logs List
    // Set up the filter
    print(filter);
    setFilter(filter);
    // Set up header with _token
    setUpDioWithHeader();
    // print('Page number in provider is $pageNumber');

    try {
      Response response = await dio.get(url, queryParameters: {
        'page': pageNumber,
        'filter': stringFilter,
      });
      // print(response.data['result']);
      response.data['result'].forEach((e) {
        final firstName = e['contact']['firstName'];
        final lastName = e['contact']['lastName'];
        final startedAt = DateTime.fromMillisecondsSinceEpoch(e['createdAt']);
        final status = checkCallLogStatus(e['direction'], e['status']);
        final twoLetter = getInitialLetter(firstName, lastName);
        // print(firstName + lastName + startedAt.toString() + direction + status);
        // });
        final newCallLog = CallLog(
          name: '$firstName $lastName',
          initialLetter: twoLetter,
          status: status,
          dateCreated: '${startedAt.day}/${startedAt.month}',
          timeCreated: '${startedAt.hour}:${startedAt.minute}',
        );
        if (filter == 'incoming') {
          _incomingCallLogs.add(newCallLog);
        } else if (filter == 'outgoing') {
          _outgoingCallLogs.add(newCallLog);
        } else if (filter == 'missed') {
          _missedCallLogs.add(newCallLog);
        } else {
          _allCallLogs.add(newCallLog);
        }
      });

      // print(_callLogs.length);
      // for (var i = 0; i < _callLogs.length; i++) {
      //   print(_callLogs[i]);
      // }
      // for (var i = 0; i < response.data['result'].length; i++) {
      //   print(response.data['result'][i]);
      // }
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

  Future<void> updatePageCallLogs(int pageNumber) async {
    // TODO: find a way to refactor 4 tabs
  }

  CallStatus checkCallLogStatus(String direction, String status) {
    print(direction + status);
    if (direction == 'outgoing') {
      return CallStatus.outgoing;
    } else {
      if (status == 'missed') {
        return CallStatus.missed;
      } else {
        return CallStatus.incoming;
      }
    }
  }

  String getInitialLetter(firstName, lastName) {
    //TODO: Implement to get 2 initial letter
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

  CallLog(
      {this.name,
      this.initialLetter,
      this.status,
      this.dateCreated,
      this.timeCreated});

  get statusString {
    if (status == CallStatus.outgoing) {
      return 'outgoing';
    } else {
      if (status == CallStatus.missed) {
        return 'missed';
      } else {
        return 'incoming';
      }
    }
  }

  @override
  String toString() {
    // TODO: implement toString

    return 'The call log from $name at $dateCreated at $timeCreated and the status is $status';
  }
}
