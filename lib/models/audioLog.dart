import 'package:flutter/foundation.dart';
import 'package:gcall/models/activity.dart';

class AudioLog extends Activity {
  final String idAudioLog;
  final String url;
  final String idContact;
  final String contactName;
  final DateTime createdAt;
  final int duration;

  AudioLog({
    @required this.idAudioLog,
    @required this.url,
    this.idContact,
    this.contactName,
    this.createdAt,
    this.duration,
  });

  String get date {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} lúc ${createdAt.hour}:${createdAt.minute}';
  }

  String get durationText {
    String _minutes = '0' + (duration / 60).floor().toString();
    String _seconds = '0' + (duration % 60).toString();
    return '${_minutes.substring(_minutes.length - 2)}:${_seconds.substring(_seconds.length - 2)}';
  }
}
