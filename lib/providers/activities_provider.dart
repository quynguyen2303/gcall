import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../models/audioLog.dart';
import '../models/activity.dart';
import '../models/note.dart';
import '../models/reminder.dart';

import '../config/Constants.dart';

class Activities extends ChangeNotifier {
  final String _token;
  // final String idContact;
  int _pageNumber = 1;
  int _prevPageNumber = 0;
  bool _isInit = true;
  bool _isSetInterceptor = false;
  List<Activity> _activities = [];

  Activities(
    this._token,
  );

  List<Activity> get activities {
    return _activities;
  }

  var dio = Dio();

  void _setUpDioWithHeader() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers['x-sessiontoken'] = _token;
    }));
    _isSetInterceptor = true;
  }

  Future<void> fetchAndSetUpActivities(
      String idContact, String contactName) async {
    print('Activity page number is $_pageNumber');

    final String url = kUrl + 'contact/$idContact/activities';
    // Check if it is already loaded this page number or not init
    if (!_isInit && _prevPageNumber >= _pageNumber) {
      print('Not Init or Already loaded this page number.');
      return;
    }

    if (!_isSetInterceptor) {
      _setUpDioWithHeader();
    }

    try {
      Response response = await dio.get(
        url,
        queryParameters: {
          'page': _pageNumber,
        },
      );
      Future.delayed(Duration(seconds: 2));
      print('The response length: ${response.data['result'].length}');
      response.data['result'].forEach(
        (activity) {
          if (activity['type'] == 'calllog') {
            String _recordUrl =  activity['body']['recordUrl'];
            bool _validUrl = Uri.parse(_recordUrl).isAbsolute;
            print(_recordUrl);
            print("The record url is $_validUrl");

            if(!_validUrl) {
              // Stop the adding if not a valid url
              return;
            }

            AudioLog audioLog = AudioLog(
              idAudioLog: activity['_id'],
              url: activity['body']['recordUrl'],
              idContact: idContact,
              contactName: contactName,
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(activity['createdAt']),
              duration: activity['body']['duration'],
            );

            print(activity['body']['duration']);
            _activities.add(audioLog);
          } else if (activity['type'] == 'note') {
            Note note = Note(
              idNote: activity['_id'],
              idContact: idContact,
              contactName: contactName,
              noteText: activity['text'],
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(activity['createdAt']),
            );
            _activities.add(note);
          } else if (activity['type'] == 'reminder') {
            Reminder reminder = Reminder(
              idReminder: activity['_id'],
              idContact: idContact,
              contactName: contactName,
              idReceiver: activity['body']['remindedAgent'],
              receiverName: 'Default', // TODO: fix receiverName
              reminderText: activity['text'],
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(activity['createdAt']),
              remindAt: DateTime.fromMillisecondsSinceEpoch(
                  activity['body']['duedate']),
              status: activity['body']['status'],
            );
            print(reminder.idContact +
                reminder.contactName +
                reminder.idReceiver +
                reminder.reminderText);
            _activities.add(reminder);
          } else {
            print('The activity type is not correct!');
          }
        },
      );
      // Set the init to false and previousPage to current page
      _isInit = false;
      _prevPageNumber = _pageNumber;

      // print(response.data['result'].length);
      // print('The activity list length: ${_activities.length}');

      // Print the activity log
      // JsonEncoder encoder = JsonEncoder.withIndent(' ');
      // String prettyPrint = encoder.convert(response.data['result']);
      // prettyPrint.split('\n').forEach((e) => print(e));

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
  }

  Future<void> deleteNote(String idContact, String idNote) async {
    final url = kUrl + 'contact/$idContact/activity/$idNote';

    if (!_isSetInterceptor) {
      _setUpDioWithHeader();
    }

    try {
      Response response = await dio.delete(
        url,
      );
      notifyListeners();

      print(response.data);
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

  Future<void> loadingMoreContacts(String idContact, String contactName) async {
    _pageNumber++;
    await fetchAndSetUpActivities(idContact, contactName);
  }

  void clearActivities() {
    if (_activities.isNotEmpty) {
      _activities = [];
    }
    _pageNumber = 1;
    _prevPageNumber = 0;
    _isInit = true;

    notifyListeners();
  }

  Future<void> createNote(String idContact, String noteText) async {
    final String url = kUrl + 'contact/$idContact/activity';

    if (!_isSetInterceptor) {
      _setUpDioWithHeader();
    }

    try {
      Response response = await dio.post(
        url,
        data: {
          "type": "note",
          "text": noteText,
        },
      );

      print(response.data);
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

  Future<void> updateNote(
      String idContact, String idNote, String noteText) async {
    final url = kUrl + 'contact/$idContact/activity/$idNote';

    if (!_isSetInterceptor) {
      _setUpDioWithHeader();
    }

    try {
      Response response = await dio.put(
        url,
        data: {
          "text": noteText,
        },
      );
      // notifyListeners();

      print(response.data);
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
