import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';

import '../config/Constants.dart';
import '../config/Pallete.dart' as Pallete;

import '../models/contact.dart';

import 'package:provider/provider.dart';
import '../providers/contacts_provider.dart';

enum ContactSex { nam, nu, khac }

class CreateContactScreen extends StatefulWidget {
  static const routeName = './create_contact';
  @override
  _CreateContactScreenState createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  ContactSex _contactSex = ContactSex.nu;
  bool _isLoading = false;
  final _form = GlobalKey<FormState>();

  final _lastnameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  Contact _newContact = Contact(
      id: DateTime.now().toString(),
      lastName: '',
      firstName: '',
      phone: '',
      email: '');

  void _saveForm() async {
    bool _isValid = _form.currentState.validate();

    if (!_isValid) {
      return;
    }

    // Save all form values to new contact
    _form.currentState.save();

    // Set the gender for the contact
    if (_contactSex == ContactSex.nam) {
      _newContact.setGender('male');
    } else if (_contactSex == ContactSex.nu) {
      _newContact.setGender('female');
    } else {
      // TODO: check options
      _newContact.setGender('none');
    }

    // Set the circulation progress on
    setState(() {
      _isLoading = true;
    });

    print(_newContact.gender);

    await Provider.of<Contacts>(context).createContact(
        _newContact.firstName,
        _newContact.lastName,
        _newContact.gender,
        _newContact.phone,
        _newContact.email);

    // Set the circulation progress off
    setState(() {
      _isLoading = false;
      Navigator.pop(context);
    });

    print('flush bar starts');

    Flushbar(
      // title: "Hey Ninja",
      icon: Icon(Icons.info, color: Pallete.primaryColor,),
      message:
          "Bạn đã tạo một liên hệ",
      duration: Duration(seconds: 2),
      // mainButton: FlatButton(
      //   color: Colors.white,
      //   child: Text('Xóa'),
      //   onPressed: () {
      //     // TODO: remove the contact
      //   },
      // ),
    )..show(context);

    // print(_newContact);
  }

  @override
  void dispose() {
    _lastnameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TẠO LIÊN HỆ',
          style: kHeaderTextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: _saveForm,
            child: Text(
              'XONG',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Tên*',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_lastnameFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Hãy nhập tên cho liên hệ.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newContact = Contact(
                          firstName: value,
                          id: _newContact.id,
                          lastName: _newContact.lastName,
                          phone: _newContact.phone,
                          email: _newContact.email,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Họ',
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _lastnameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_phoneFocusNode);
                      },
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return null;
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _newContact = Contact(
                          firstName: _newContact.firstName,
                          id: _newContact.id,
                          lastName: value ?? '',
                          phone: _newContact.phone,
                          email: _newContact.email,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại*',
                      ),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      focusNode: _phoneFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Hãy nhập số điện thoại cho liên hệ.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newContact = Contact(
                          firstName: _newContact.firstName,
                          id: _newContact.id,
                          lastName: _newContact.lastName,
                          phone: value,
                          email: _newContact.email,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return null;
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _newContact = Contact(
                          firstName: _newContact.firstName,
                          id: _newContact.id,
                          lastName: _newContact.lastName,
                          phone: _newContact.phone,
                          email: value ?? '',
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Giới tính',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              LabeledRadio(
                                label: 'Nữ',
                                padding: EdgeInsets.all(0),
                                groupValue: _contactSex,
                                value: ContactSex.nu,
                                onChanged: (ContactSex newValue) {
                                  setState(() {
                                    _contactSex = newValue;
                                  });
                                },
                              ),
                              LabeledRadio(
                                label: 'Nam',
                                padding: EdgeInsets.all(0),
                                groupValue: _contactSex,
                                value: ContactSex.nam,
                                onChanged: (ContactSex newValue) {
                                  setState(() {
                                    _contactSex = newValue;
                                  });
                                },
                              ),
                              LabeledRadio(
                                label: 'Khác',
                                padding: EdgeInsets.all(0),
                                groupValue: _contactSex,
                                value: ContactSex.khac,
                                onChanged: (ContactSex newValue) {
                                  setState(() {
                                    _contactSex = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ),
    );
  }
}

class LabeledRadio extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final ContactSex groupValue;
  final ContactSex value;
  final Function onChanged;

  const LabeledRadio(
      {this.label, this.padding, this.groupValue, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<ContactSex>(
              groupValue: groupValue,
              value: value,
              onChanged: (ContactSex newValue) {
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
