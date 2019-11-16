import 'package:flutter/foundation.dart';
import 'package:gcall/models/activity.dart';


class AudioLog extends Activity {
  final String url;
  final String idContact;
  final String contactName;
  final DateTime createdAt;

  AudioLog(
      {@required this.url, this.idContact, this.contactName, this.createdAt});

  String get date {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} lúc ${createdAt.hour}:${createdAt.minute}';
  }
}
