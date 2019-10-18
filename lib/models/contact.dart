
class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  String gender;

  Contact({this.id, this.firstName, this.lastName, this.phone, this.email, this.gender});

  String get displayName {
    return ((this.firstName?.isNotEmpty == true ? this.firstName : "") +
        ' ' +
        (this.lastName?.isNotEmpty == true ? this.lastName : ""));
  }

  String get initials {
    return ((this.firstName?.isNotEmpty == true ? this.firstName[0] : "") +
            (this.lastName?.isNotEmpty == true ? this.lastName[0] : ""))
        .toUpperCase();
  }

  // String get emailInfo {
  //   return email;
  // }

  // String get phoneInfo {
  //   return phone; {}
  // }

  String get genderInfo {
    if (gender == 'male') {
      return 'Nam';
    } else {
      if (gender == 'female') {
        return 'Nữ';
      } else {
        return 'Khác';
      }
    }
  }
  void setGender(String value) {
    this.gender = value;
  }

  @override
  String toString() {
    return 'The contact info is id: $id , firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, gender: $gender';
  }
}
