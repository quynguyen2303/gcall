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

  Future<void> fetchAndSetUpActivities(
      String idContact, String contactName) async {
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
            AudioLog audioLog = AudioLog(
              url: activity['body']['recordUrl'],
              idContact: idContact,
              contactName: contactName,
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(activity['createdAt']),
              duration: activity['body']['duration'],
            );
            activities.add(audioLog);
          } else if (activity['type'] == 'note') {
            Note note = Note(
              idContact: idContact,
              contactName: contactName,
              noteText: activity['text'],
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(activity['createdAt']),
            );
            activities.add(note);
          } else if (activity['type'] == 'reminder') {
            Reminder reminder = Reminder(
              idContact: idContact,
              contactName: contactName,
              idReceiver: activity['body']['remindedAgent'],
              receiverName: 'Default', // TODO: fix receiverName
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(activity['createdAt']),
              remindAt: DateTime.fromMillisecondsSinceEpoch(
                  activity['body']['duedate']),
              status: activity['body']['status'],
            );
            activities.add(reminder);
          } else {
            print('The activity type is not correct!');
          }
        },
      );
      print(response.data['result'].length);

      // JsonEncoder encoder = JsonEncoder.withIndent(' ');
      // String prettyPrint = encoder.convert(response.data['result']);
      // prettyPrint.split('\n').forEach((e) => print(e));
      print(activities.length);
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
