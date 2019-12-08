import 'package:flutter/material.dart';

import '../config/Constants.dart';

class PlayerItem extends StatefulWidget {
  @override
  _PlayerItemState createState() => _PlayerItemState();
  final String idAudioLog;
  final String url;
  final String contactName;
  final String createdAt;
  final String duration;

  PlayerItem(
      {@required this.idAudioLog,
      this.url,
      this.contactName,
      this.createdAt,
      this.duration});
}

class _PlayerItemState extends State<PlayerItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, color: Colors.black26),
                  borderRadius: BorderRadius.circular(4),
                )),
                padding: EdgeInsets.all(3.0),
                child: ImageIcon(
                  AssetImage(kPhoneIncoming),
                  color: Colors.green,
                  size: 20,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Bạn đã nhận cuộc gọi từ ',
                        style: kNormalTextStyle,
                        children: [
                          TextSpan(
                            text: '${widget.contactName}',
                            style: kReminderTitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.createdAt,
                      style: kTimeCallHistoryTextStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: ImageIcon(
                  AssetImage(kDownload),
                  size: 16,
                  // color: Colors.black,
                ),
                onPressed: () {
                  // TODO: add MORE functionality
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.play_arrow),
              SizedBox(
                width: 200,
                height: 30,
                child: SliderTheme(
                  data: SliderThemeData(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                    trackHeight: 3,
                    thumbColor: Colors.pink,
                    inactiveTrackColor: Colors.grey,
                    activeTrackColor: Colors.pink,
                    overlayColor: Colors.transparent,
                  ),
                  child: Slider(
                    value: 0.0,
                    // _position != null ? _position.inMilliseconds.toDouble() : 0.0,
                    min: 0.0,
                    max: 400.0,
                    // _duration != null ? _duration.inMilliseconds.toDouble() : 0.0,
                    onChanged: (double value) async {
                      // final Result result = await _audioPlayer
                      //     .seekPosition(Duration(milliseconds: value.toInt()));
                      // if (result == Result.FAIL) {
                      //   print(
                      //       "you tried to call audio conrolling methods on released audio player :(");
                      // } else if (result == Result.ERROR) {
                      //   print("something went wrong in seek :(");
                      // }
                      // _position = Duration(milliseconds: value.toInt());
                    },
                  ),
                ),
              ),
              Text('00:00 / ${widget.duration}'),
            ],
          ),
        ],
      ),
    );
  }
}
