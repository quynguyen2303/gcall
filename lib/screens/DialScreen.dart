import 'package:flutter/material.dart';

import '../config/Pallete.dart' as Pallete;

import '../widgets/DialWidget.dart';

class DialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DialWidget(
        buttonColor: Colors.white,
        buttonTextColor: Pallete.primaryColor,
        backspaceButtonIconColor: Colors.red,
      ),
    );
  }
}
