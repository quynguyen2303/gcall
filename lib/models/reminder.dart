import 'package:gcall/models/activity.dart';

class Reminder extends Activity {
  final String idContact;
  final String contactName;
  final String idReceiver;
  final String receiverName;
  String reminderText;
  final DateTime createdAt;
  final DateTime remindAt;
  final String status;

  Reminder(
      {this.idContact,
      this.contactName,
      this.idReceiver,
      this.receiverName,
      this.reminderText,
      this.createdAt,
      this.remindAt,
      this.status});

  String get date {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} lúc ${createdAt.hour}:${createdAt.minute}';
  }

  String get remindWhen {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} - ${createdAt.hour}:${createdAt.minute}';
  }
}
