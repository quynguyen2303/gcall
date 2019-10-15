import 'package:flutter/material.dart';

import '../config/Constants.dart';

enum ContactSex { nam, nu, khac }

class CreateContactScreen extends StatefulWidget {
  static const routeName = './create_contact';
  @override
  _CreateContactScreenState createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  ContactSex _contaxtSex = ContactSex.nu;
  final _form = GlobalKey<FormState>();

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
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('XONG', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: Container(
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
                  // TODO: when submit this text field
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Hãy nhập tên cho liên hệ.';
                  }
                  return null;
                },
                onSaved: (value) {
                  // TODO : when save the whole form
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Họ',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  // TODO: when submit this text field
                },
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return null;
                //   }
                //   return null;
                // },
                onSaved: (value) {
                  // TODO : when save the whole form
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Số điện thoại*',
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  // TODO: when submit this text field
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Hãy nhập số điện thoại cho liên hệ.';
                  }
                  return null;
                },
                onSaved: (value) {
                  // TODO : when save the whole form
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  // TODO: when submit this text field
                },
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return null;
                //   }
                //   return null;
                // },
                onSaved: (value) {
                  // TODO : when save the whole form
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
                          groupValue: _contaxtSex,
                          value: ContactSex.nu,
                          onChanged: (ContactSex newValue) {
                            setState(() {
                              _contaxtSex = newValue;
                            });
                          },

                        ),LabeledRadio(
                          label: 'Nam',
                          padding: EdgeInsets.all(0),
                          groupValue: _contaxtSex,
                          value: ContactSex.nam,
                          onChanged: (ContactSex newValue) {
                            setState(() {
                              _contaxtSex = newValue;
                            });
                          },

                        ),LabeledRadio(
                          label: 'Khác',
                          padding: EdgeInsets.all(0),
                          groupValue: _contaxtSex,
                          value: ContactSex.khac,
                          onChanged: (ContactSex newValue) {
                            setState(() {
                              _contaxtSex = newValue;
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
