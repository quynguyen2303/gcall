import 'package:flutter/foundation.dart';

class AudioLog {
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
