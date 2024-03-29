import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../config/Constants.dart';

enum CallStatus { outgoing, incoming, missed }

class CallLogs extends ChangeNotifier {
  final String _token;
  String stringFilter;
  bool _isSetInterceptor = false;

  List<CallLog> _allCallLogs = [];
  List<CallLog> _incomingCallLogs = [];
  List<CallLog> _outgoingCallLogs = [];
  List<CallLog> _missedCallLogs = [];

  int _currentAllPage = 1;
  int _currentIncPage = 1;
  int _currentOutPage = 1;
  int _currentMissPage = 1;

  int _previousAllPage = 0;
  int _previousIncPage = 0;
  int _previousOutPage = 0;
  int _previousMissPage = 0;

  var dio = Dio();
  final String url = kUrl + 'calllogs';

  CallLogs(this._token);

  List<CallLog> getCallLogs(String filter) {
    if (filter == '') {
      return _allCallLogs;
    } else if (filter == 'incoming') {
      return _incomingCallLogs;
    } else if (filter == 'outgoing') {
      return _outgoingCallLogs;
    } else if (filter == 'missed') {
      return _missedCallLogs;
    } else {
      return [];
    }
  }

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
  void _setUpDioWithHeader() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = _token;
    }));
    _isSetInterceptor = true;
  }

  void _setFilter(String filter) {
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

  bool _isDuplicatePage(String filter) {
    if (filter == 'incoming') {
      return _previousIncPage >= _currentIncPage;
    } else if (filter == 'outgoing') {
      return _previousOutPage >= _currentOutPage;
    } else if (filter == 'missed') {
      return _previousMissPage >= _currentMissPage;
    } else {
      return _previousAllPage >= _currentAllPage;
    }
  }

  int _setPageNumber(String filter) {
    if (filter == 'incoming') {
      return _currentIncPage;
    } else if (filter == 'outgoing') {
      return _currentOutPage;
    } else if (filter == 'missed') {
      return _currentMissPage;
    } else {
      return _currentAllPage;
    }
  }

  void _setPreviousPage(int currentPage, String filter) {
    if (filter == 'incoming') {
      _previousIncPage = currentPage;
    } else if (filter == 'outgoing') {
      _previousOutPage = currentPage;
    } else if (filter == 'missed') {
      _previousMissPage = currentPage;
    } else {
      _previousAllPage = currentPage;
    }
  }

  Future<void> loadingMoreCallLogs([String filter = '']) async {
    if (filter == 'incoming') {
      _currentIncPage++;
    } else if (filter == 'outgoing') {
      _currentOutPage++;
    } else if (filter == 'missed') {
      _currentMissPage++;
    } else {
      _currentAllPage++;
    }
    await fetchAndSetCallLogs(filter);
  }

  Future<void> fetchAndSetCallLogs([String filter = '']) async {
    // Set up Call Logs List
    // Set up the filter
    // print(filter);
    _setFilter(filter);
    // Set up header with _token
    if (!_isSetInterceptor) {
      _setUpDioWithHeader();
    }
    // Check _previous page and current page
    if (_isDuplicatePage(filter)) {
      print('Not Init or Duplicate');
      return;
    }

    try {
      int pageNumber = _setPageNumber(filter);
      print('Page number of $filter is: $pageNumber');
      Response response = await dio.get(url, queryParameters: {
        'page': pageNumber,
        'filter': stringFilter,
      });
      // print(response.data['result'].length);
      response.data['result'].forEach((e) {
        final firstName = e['contact']['firstName'];
        final lastName = e['contact']['lastName'];
        final startedAt = DateTime.fromMillisecondsSinceEpoch(e['createdAt']);
        final status = _checkCallLogStatus(e['direction'], e['status']);
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

      print(_allCallLogs.length);

      // Update _previous page
      _setPreviousPage(pageNumber, filter);
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
    notifyListeners();
    // print(callLogs);
    // print(callLogs[1]['_id']+ " & contact id: " + callLogs[1]['contact']['_id']);
    // print(callLogs[2]['_id']+ " & contact id: " + callLogs[2]['contact']['_id']);
  }

  CallStatus _checkCallLogStatus(String direction, String status) {
    // print(direction + status);
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

  String getInitialLetter(String firstName, String lastName) {
    return ((firstName?.isNotEmpty == true ? firstName[0] : "") +
            (lastName?.isNotEmpty == true ? lastName[0] : ""))
        .toUpperCase();
  }
  //   String name;
  //   // print(firstName + ' and ' + lastName);
  //   if (firstName == '' && lastName != '') {
  //     // print(object)
  //     name = lastName[0];
  //   } else if (lastName == '' && firstName != '') {
  //     final splittedName = firstName.split(' ');
  //     // print(splittedName);
  //     if (splittedName.length > 1) {
  //       name = splittedName[0][0] + splittedName[1][0];
  //     } else {
  //       name = firstName[0];
  //     }
  //   } else {
  //     name = firstName[0] + lastName[0];
  //   }
  //   return name;
  // }
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

  // @override
  // String toString() {
  //   // : implement toString
  //   return 'The call log from $name at $dateCreated at $timeCreated and the status is $status';
  // }
}
