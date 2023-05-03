import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uhf2new/modle/tag_epc.dart';
import 'package:uhf2new/uhf2new.dart';

import '../keyboard_event_listner/key_board_event_listmner.dart';

class RFIDListner extends StatefulWidget {
  const RFIDListner({Key? key, required this.child, required this.listen});
  final Widget child;
  final Function(TagEpc) listen;

  @override
  State<RFIDListner> createState() => _RFIDListnerState();
}

class _RFIDListnerState extends State<RFIDListner> {
  /// Returns [value] plus 1.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  CustomeKeyBoardListner(
      keysFunction: (value) {
        print("name $value");
        Future.delayed(Duration.zero,() async{
          bool? isStarted = await Uhf2new.startSingle;
          log('Start single $isStarted');
        });
      },
      keyEvents: {},
      child: widget.child,
    );
  }
}
