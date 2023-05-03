// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:uhf_c72_plugin/tag_epc.dart';
// import 'package:uhf_c72_plugin/uhf_c72_plugin.dart';
//
// import '../keyboard_event_listner/key_board_event_listmner.dart';
// import 'controller/rfid_controller.dart';
//
// class RFIDBuilder extends StatelessWidget with RFIDController{
//   const RFIDBuilder({Key? key, required this.child});
//   final Widget Function(BuildContext, TagEpc) child;
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//    return  CustomeKeyBoardListner(
//      keysFunction: (value) {
//        print("name $value");
//        Future.delayed(Duration.zero,() async{
//          bool? isStarted = await UhfC72Plugin.startSingle;
//          log('Start single $isStarted');
//        });
//      },
//      keyEvents: {},
//      child: StreamBuilder<dynamic>(
//        stream: stream(),
//        builder: (context,snap) {
//          return child(context,TagEpc.parseTags(snap.data).first);
//        }
//      ),
//    );
//   }
// }
// class RFIDListner extends StatefulWidget with RFIDController{
//   const RFIDListner({Key? key, required this.child, required this.listen});
//   final Widget child;
//   final Function(TagEpc) listen;
//
//   @override
//   State<RFIDListner> createState() => _RFIDListnerState();
// }
//
// class _RFIDListnerState extends State<RFIDListner> {
//   /// Returns [value] plus 1.
//
// @override
//   void initState() {
//     // TODO: implement initState
//   widget.initilize();
//     widget.stream().listen((event) {
//       widget.listen(TagEpc.parseTags(event).first);
//     });
//   super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//    return  CustomeKeyBoardListner(
//      keysFunction: (value) {
//        print("name $value");
//        Future.delayed(Duration.zero,() async{
//          bool? isStarted = await UhfC72Plugin.startSingle;
//          log('Start single $isStarted');
//        });
//      },
//      keyEvents: {},
//      child: widget.child,
//    );
//   }
// }
