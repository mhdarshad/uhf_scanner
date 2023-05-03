import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:uhf2new/interface/uhf2new_platform_interface.dart';
import 'package:uhf2new/modle/tag_epc.dart';
import 'package:uhf2new/uhf2new.dart';

import 'container/keyboard_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController powerLevelController =TextEditingController(text: '26');
  TextEditingController workAreaController = TextEditingController(text: '1');
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Uhf2new.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    Uhf2new.connectedStatusStream
        .receiveBroadcastStream()
        .listen(updateIsConnected);
    Uhf2new.tagsStatusStream.receiveBroadcastStream().listen(updateTags);
    Uhf2new.keyBoardEvent.receiveBroadcastStream().listen(updateKeyBoard);
    await Uhf2new.connect;
    await Uhf2new.setWorkArea('2');
    await Uhf2new.setPowerLevel('30');
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

  }

  final List<String> _logs = [];
  void log(String msg) {
    setState(() {
      _logs.add(msg);
    });
  }

  List<TagEpc> _data = [];
  void updateTags(dynamic result) {
    log('update tags');
    setState(() {
      _data = TagEpc.parseTags(result);
    });
  }
  void updateKeyBoard(result) {
    log('update Keyboard');
    setState(() {
      _data = TagEpc.parseTags(result);
    });
  }
  void updateIsConnected(dynamic isConnected) {
    log('connected $isConnected');

  }

  @override
  Widget build(BuildContext context) {
    //_data.add(TagEpc(count: 10, epc: '5SETF7656GGY5578'));
    //_data.add(TagEpc(count: 10, epc: '6757568YG76658GH'));
    // _data.add(TagEpc(count: 10, epc: 'TNB75G568YG758GH'));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('UHF PROGAZE'),
        ),
        body: RFIDListner(
          listen: (tag ) {

          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      'assets/logo.png',
                      width: double.infinity,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.blueAccent,
                        child: const Text(
                          'Call Start Single',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          bool? isStarted = await Uhf2new.startSingle;
                          log('Start signle $isStarted');
                        }),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.blueAccent,
                        child: const Text(
                          'Call Start Continuous Reading',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          bool? isStarted = await Uhf2new.startContinuous;
                          log('Start Continuous $isStarted');
                        }),
                    /* MaterialButton(
                        child: Text('Call isStarted'),
                        onPressed: () async {
                          bool isStarted = await Uhf2new.isStarted;
                          setState(() {
                            this._isStarted = isStarted;
                          });
                        }),*/
                  ],
                ),
                /*Text(
                  'UHF Reader isStarted:$_isStarted',
                  style: TextStyle(color: Colors.blue.shade800),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[*/
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.blueAccent,
                    child: const Text(
                      'Call Stop',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      bool isStopped = await Uhf2new.stop??false;
                      log('Stop $isStopped');
                    }),
                /*   MaterialButton(
                        child: Text('Call Close'),
                        onPressed: () async {
                          await Uhf2new.close;
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[*/
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.blueAccent,
                    child: const Text(
                      'Call Clear Data',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await Uhf2new.clearData;
                      setState(() {
                        _data = [];
                      });
                    }),
                /* MaterialButton(
                        child: Text('Call is Empty Tags'),
                        onPressed: () async {
                          bool isEmptyTags = await Uhf2new.isEmptyTags;
                          setState(() {
                            this._isEmptyTags = isEmptyTags;
                          });
                        }),
                  ],
                ),
                Text(
                  'UHF Reader isEmptyTags:$_isEmptyTags',
                  style: TextStyle(color: Colors.blue.shade800),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: powerLevelController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(labelText: 'Power Level'),
                      ),
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.green,
                        child: const Text(
                          'Set Power Level',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          bool? isSetPower = await Uhf2new.setPowerLevel(
                              powerLevelController.text);
                          log('isSetPower $isSetPower');
                        }),
                  ],
                ),
                Text(
                  'powers {"5" : "30" dBm}',
                  style: TextStyle(color: Colors.blue.shade800, fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: workAreaController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(labelText: 'Work Area'),
                      ),
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.green,
                        child: const Text(
                          'Set Work Area',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          bool? isSetWorkArea = await Uhf2new.setWorkArea(
                              workAreaController.text);
                          log('isSetWorkArea $isSetWorkArea');
                        }),
                  ],
                ),
                Text(
                  'Work Area 1 China 920MHz - 2 China 840 - 3 ETSI 865\n4 Fixed 915 - 5 USA 902',
                  style: TextStyle(color: Colors.blue.shade800, fontSize: 12),
                ),
                Container(
                  width: double.infinity,
                  height: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.blueAccent,
                ),
                Row(children: [
                  Expanded(child: Column(children: [
                    ..._logs.map((String msg) => Card(
                      color: Colors.blue.shade50,
                      child: Container(
                        width: 330,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Log: $msg',
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      ),
                    )),
                  ],)),
                  Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start,children: [
                    ..._data.map((TagEpc tag) => Card(
                      color: Colors.blue.shade50,
                      child: Container(
                        width: 330,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Tag ${tag.epc} Count:${tag.count}',
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      ),
                    )),
                  ],))

                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }


}
