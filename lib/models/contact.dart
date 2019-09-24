class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;

  Contact({this.id, this.firstName, this.lastName, this.phone});

  String get displayName {
    return ((this.firstName?.isNotEmpty == true ? this.firstName : "") +
        ' ' +
        (this.lastName?.isNotEmpty == true ? this.lastName : ""));
  }

  String initials() {
    return ((this.firstName?.isNotEmpty == true ? this.firstName[0] : "") +
            (this.lastName?.isNotEmpty == true ? this.lastName[0] : ""))
        .toUpperCase();
  }
}
