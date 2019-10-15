import 'package:flutter/material.dart';
import 'Pallete.dart' as Pallete;

// API
const kUrl = 'https://mobile-docker.gcall.vn/'; 

enum ContactSex { nam, nu, khac }

// Icons
const kPhoneIncoming = 'assets/icons/phone_incoming.png';
const kPhoneButton = 'assets/icons/phone_button.png';
const kBanner = 'assets/photos/banner.png';

// Fonts and Text Styles
const _primaryFontFamily = 'OpenSans';

const kHeaderTextStyle = TextStyle(
    fontFamily: _primaryFontFamily, fontWeight: FontWeight.bold, fontSize: 24);
const kContactCallHistoryTextStyle = TextStyle(
    fontSize: 16,
    color: Pallete.primaryTextColor,
    fontFamily: _primaryFontFamily,
    fontWeight: FontWeight.w600);
const kTimeCallHistoryTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: _primaryFontFamily,
    color: Pallete.primaryTextColor);
const kContactNameTextStyle = TextStyle(
    fontSize: 20,
    color: Pallete.primaryTextColor,
    fontFamily: _primaryFontFamily,
    fontWeight: FontWeight.w600);
