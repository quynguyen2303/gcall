class Note {
  final String idContact;
  final String contactName;
  String noteText;
  final DateTime createdAt;

  Note({this.idContact, this.contactName, this.noteText, this.createdAt});

  String get date {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} lúc ${createdAt.hour}:${createdAt.minute}';
  }
}
