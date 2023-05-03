


import 'package:uhf2new/uhf2new.dart';

enum WorkAreas{
  china90MHZ,china840,etsi865,fixed915,usa920
}
class RFIDController{
  Future<bool?> setWorkAria(WorkAreas value) async {
    String workArea = '';
    switch(value){

      case WorkAreas.china90MHZ:
        workArea = '1';
        break;
      case WorkAreas.china840:
        workArea = '2';
        break;
      case WorkAreas.etsi865:
        workArea = '3';
        break;
      case WorkAreas.fixed915:
        workArea = '4';
        break;
      case WorkAreas.usa920:
        workArea = '5';
        break;
    }
    return await Uhf2new.setWorkArea(workArea);
  }
  Future<bool?> powerLevel(int value) async=>await Uhf2new.setPowerLevel(value.toString());
  Future<bool?> scanTrigger() async {
   if((await Uhf2new.isConnected??false)) {
     await powerLevel(5);
     await Uhf2new.clearData;
      return await Uhf2new.startSingle;
    }else{
initilize(listen: (listen){});   }
  }
  Future<bool?> scanContinues(int value) async=>await Uhf2new.startContinuous;
  Future<bool?> clear() async=>await Uhf2new.clearData;
  Future<bool?> get isConnected async=>await Uhf2new.isConnected;
  Future<bool?> close() async=>await Uhf2new.close;
  Future<bool?> stop() async=>(await Uhf2new.isStarted??false)?await Uhf2new.stop: null;
  Stream<dynamic> stream() => Uhf2new.tagsStatusStream.receiveBroadcastStream();
  initilize({required  Function(dynamic value) listen}) async {
    Uhf2new.connectedStatusStream
        .receiveBroadcastStream()
        .listen(updateIsConnected);
    Uhf2new.tagsStatusStream.receiveBroadcastStream().listen((value) async {
      print(value.toString());
      return await listen(value);
    },onError: (e){
      print(e.toString());
    });
   if (!(await Uhf2new.isConnected??false))
    {
    // Uhf2new.connectedStatusStream.receiveBroadcastStream().listen(updateIsConnected);
    // Uhf2new.tagsStatusStream.receiveBroadcastStream().listen((value) async{
    // await listen(value);
    // });
    await Uhf2new.connect;
    await setWorkAria(WorkAreas.china840);
    await powerLevel(2);

    // Uhf2new.keyBoardEvent.receiveBroadcastStream().listen(updateKeyBoard);
    // await Uhf2new.connect;
    // await Uhf2new.setWorkArea('2');
    // await Uhf2new.setPowerLevel('30');
  }
  }
  dispose() async{
    await clear();
    await stop();
  }
  void updateIsConnected(dynamic isConnected) {
    print('connected $isConnected');
  }
}
