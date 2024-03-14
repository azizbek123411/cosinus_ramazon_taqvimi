


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../ui/pages/splash_page/time_location.dart';
import '../models/mosque_model.dart';
import '../models/pray_model.dart';
import '../service/api_service.dart';

final _myBox=Hive.box("address");
final namozTimes = FutureProvider<List<PrayModel?>>((ref) async {
  return await ApiService.getData(city: _myBox.get(1), month: DateTime.now().month,);
});



final mosqueProvider=FutureProvider<List<MosqueModel?>>((ref)async{
  return await ApiService.getMosques();
});



final distanceProvider=FutureProvider<List<MosqueModel?>>((ref) async{
  return await ApiService.calculateDistances();
});



