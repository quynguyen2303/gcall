class Note {
  final String idContact;
  final String nameContact;
  String noteText;
  final DateTime createdAt;

  Note({this.idContact, this.nameContact, this.noteText, this.createdAt});

  String get date {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} lúc ${createdAt.hour}:${createdAt.minute}';
  }
}
