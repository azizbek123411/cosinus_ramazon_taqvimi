import 'dart:convert';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart';

import '../models/mosque_model.dart';
import '../models/pray_model.dart';


class ApiService {
  //https://islomapi.uz/api/monthly?region=Toshkent&month=4
  //https://admin13.uz/api/mosque/
  static mosqueUrl() {
    final Uri uri = Uri.parse("https://admin13.uz/api/mosque/");
    return uri;
  }

  static Future<List<MosqueModel?>> getMosques() async {
    List<MosqueModel> mosques = [];
    final response = await get(mosqueUrl());
    // log(response.body);
    if (response.statusCode == 200) {
      final dataList = jsonDecode(response.body);
      for (final item in dataList) {
        try {
          mosques.add(MosqueModel.fromJson(item));
        } catch (e, st) {
          log(e.toString(), stackTrace: st);
        }
      }
    }
    return mosques;
  }

  static Position? currentLocation;
  late bool servicePermission;
  late LocationPermission permission;

  Future<Position> getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {}
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future calculateDistances() async {
    List<MosqueModel> distances = [];
    final response = await get(mosqueUrl());
    if (response.statusCode == 200) {
      final dataList = jsonDecode(response.body);
      for (final item in dataList) {
        try {
          double distanceInMeters = Geolocator.distanceBetween(
              // currentLocation?.latitude??0,
              // currentLocation?.longitude??0,
              41.2744398,
              69.2004313,
              MosqueModel.fromJson(item).lat,
              MosqueModel.fromJson(item).long,);
          if (distanceInMeters <= 3000) {
            distances.add(MosqueModel.fromJson(item));
          }
        } catch (e, st) {
          log(e.toString(), stackTrace: st);
        }
      }
    }
    return distances;
  }

  static resultPath({
    required String city,
    required int month,
  }) {
    final Uri uri =
        Uri.parse("https://islomapi.uz/api/monthly?region=$city&month=$month");
    return uri;
  }

  static Future<List<PrayModel?>> getData({
    required String city,
    required int month,
  }) async {
    List<PrayModel> getTimes = [];
    final response = await get(
      resultPath(city: city, month: month),
    );
    log(response.body);
    if (response.statusCode == 200) {
      final dataList = jsonDecode(response.body);
      for (final item in dataList) {
        try {
          getTimes.add(PrayModel.fromJson(item));
        } catch (e, st) {
          log("Error", error: e, stackTrace: st);
        }
      }
    }
    return getTimes;
  }

// static Future<PrayModel?> getData({
//   required String city,
//   required int month
// }) async {
//   // List<NamozModel> getTimes = [];
//   final response = await get(resultPath(city: city,month: month));
//   log(response.body);
//   if (response.statusCode == 200) {
//     final dataList = jsonDecode(response.body);
//     return PrayModel.fromJson(dataList[1]);
//   }
//   log(response.body);
//   return null;
// }
}
