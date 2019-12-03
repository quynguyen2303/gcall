import 'package:flutter/material.dart';
import 'Pallete.dart' as Pallete;

// API
const kUrl = 'https://mobile-docker.gcall.vn/';

enum ContactSex { nam, nu, khac }

// Icons
const kPhoneIncoming = 'assets/icons/phone_incoming.png';
const kPhoneButton = 'assets/icons/phone_button.png';
const kBanner = 'assets/photos/banner.png';
const kNoteAdd = 'assets/icons/note_add.png';
const kNoteSquare = 'assets/icons/note_square.png';
const kReminder = 'assets/icons/alarm.png';
const kMoreButton = 'assets/icons/more_button.png';
const KRemindSquare = 'assets/icons/remind_square.png';
const kDownload = 'assets/icons/download_button.png';

const kActivityIconWidth = 30.0;
const kActivityIconHeight = 30.0;

// Fonts and Text Styles
const primaryFontFamily = 'OpenSans';

const kHeaderTextStyle = TextStyle(
    fontFamily: primaryFontFamily, fontWeight: FontWeight.bold, fontSize: 24);
const kContactCallHistoryTextStyle = TextStyle(
    fontSize: 16,
    color: Pallete.primaryTextColor,
    fontFamily: primaryFontFamily,
    fontWeight: FontWeight.w600);
const kTimeCallHistoryTextStyle = TextStyle(
  fontSize: 12,
  fontFamily: primaryFontFamily,
  color: Pallete.primaryTextColor,
);
const kContactNameTextStyle = TextStyle(
    fontSize: 20,
    color: Pallete.primaryTextColor,
    fontFamily: primaryFontFamily,
    fontWeight: FontWeight.w600);
const kReminderTitleTextStyle = TextStyle(
    fontSize: 14,
    color: Pallete.primaryTextColor,
    fontFamily: primaryFontFamily,
    fontWeight: FontWeight.w600);
const kNoteTimeTextStyle = TextStyle(
  fontSize: 12,
  fontFamily: primaryFontFamily,
  color: Pallete.primaryTextColor,
);
const kNormalTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontFamily: primaryFontFamily);
const kNoteTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: Colors.black,
  fontFamily: primaryFontFamily,
);
