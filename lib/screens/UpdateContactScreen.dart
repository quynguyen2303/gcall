import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';

import '../config/Constants.dart';
import '../config/Pallete.dart' as Pallete;

import 'ContactsScreen.dart';

import '../models/contact.dart';

import 'package:provider/provider.dart';
import '../providers/contacts_provider.dart';

enum ContactSex { nam, nu, khac }

class UpdateContactScreen extends StatefulWidget {
  final String contactId;
  UpdateContactScreen({this.contactId});

  static const routeName = './update_contact';

  @override
  _UpdateContactScreenState createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  ContactSex _contactSex = ContactSex.nu;
  bool _isInit = true;
  final _form = GlobalKey<FormState>();

  final _lastnameFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  Future<void> _isLoadingContact;

  Contact _previousContact;

  void _saveForm() async {
    bool _isValid = _form.currentState.validate();

    if (!_isValid) {
      return;
    }

    // Save all form values to new contact
    _form.currentState.save();

    // Set the gender for the contact
    if (_contactSex == ContactSex.nam) {
      _previousContact.setGender('male');
    } else if (_contactSex == ContactSex.nu) {
      _previousContact.setGender('female');
    } else {
      _previousContact.setGender('unknown');
    }

    await Provider.of<Contacts>(context, listen: false).updateContact(
        _previousContact.id,
        _previousContact.firstName,
        _previousContact.lastName,
        _previousContact.gender,
        _previousContact.email);

    Navigator.pop(context);

    Flushbar(
      // title: "Hey Ninja",
      icon: Icon(
        Icons.info,
        color: Pallete.primaryColor,
      ),
      message: "Bạn đã chỉnh sửa một liên hệ",
      duration: Duration(seconds: 2),
    )..show(context);
  }

  Future<void> _showDeleteDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('BẠN CÓ CHẮC MUỐN XÓA?'),
            content: Text('Bạn sẽ không thể khôi phục được dữ liệu đã xóa.'),
            actions: <Widget>[
              FlatButton(
                child: Text('HỦY'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('XÓA'),
                onPressed: () async {
                  await Provider.of<Contacts>(context, listen: false)
                      .deleteContact(_previousContact.id);
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  // Future.delayed(Duration(seconds: 0));
                  // Navigator.of(context)
                  //     .popUntil(ModalRoute.withName(ContactsScreen.routeName));
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // final ContactDetailScreen args = ModalRoute.of(context).settings.arguments;
    // id = args.id;
    _isLoadingContact =
        Provider.of<Contacts>(context, listen: false).getOneContact(widget.contactId);
    super.initState();
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
    print('Update Contact Build calls...');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHỈNH SỬA LIÊN HỆ',
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
      body: FutureBuilder(
        future: _isLoadingContact,
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              //TODO: make it more explainable
              return Center(
                child: Text('Got an error'),
              );
            } else {
              // Get the previous contact info
              if (_isInit) {
                print('_isInit is $_isInit');
                Contact previousContact =
                    Provider.of<Contacts>(context, listen: false).contactInfo;
                _previousContact = previousContact;
                print('Contact information in Update:...');
                print(_previousContact.toString());
                // Set the contact sex to enumerate
                if (previousContact.gender == 'male') {
                  _contactSex = ContactSex.nam;
                } else {
                  if (previousContact.gender == 'female') {
                    _contactSex = ContactSex.nu;
                  } else {
                    _contactSex = ContactSex.khac;
                  }
                }
                _isInit = false;
                print('Set _isInit to false: $_isInit');
              }

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _previousContact.firstName,
                        decoration: InputDecoration(
                          labelText: 'Tên*',
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_lastnameFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Hãy nhập tên cho liên hệ.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _previousContact = Contact(
                            firstName: value,
                            id: _previousContact.id,
                            lastName: _previousContact.lastName,
                            phone: _previousContact.phone,
                            email: _previousContact.email,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _previousContact.lastName,
                        decoration: InputDecoration(
                          labelText: 'Họ',
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _lastnameFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        onSaved: (value) {
                          _previousContact = Contact(
                            firstName: _previousContact.firstName,
                            id: _previousContact.id,
                            lastName: value ?? '',
                            phone: _previousContact.phone,
                            email: _previousContact.email,
                          );
                        },
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: _previousContact.phone,
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại (không thể sửa)',
                        ),
                      ),
                      TextFormField(
                        initialValue: _previousContact.email,
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
                          _previousContact = Contact(
                            firstName: _previousContact.firstName,
                            id: _previousContact.id,
                            lastName: _previousContact.lastName,
                            phone: _previousContact.phone,
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
                      ),
                      RaisedButton(
                        color: Colors.white,
                        textColor: Colors.red,
                        child: Text(
                          'Xóa liên hệ',
                        ),
                        onPressed: () async {
                          // TODO: delete the contact
                          await _showDeleteDialog();
                        },
                      ),
                    ],
                  )),
                ),
              );
            }
          }
        },
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
