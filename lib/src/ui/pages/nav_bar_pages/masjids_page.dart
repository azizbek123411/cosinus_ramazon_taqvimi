import 'dart:developer';

import 'package:cosinus_ramazon_taqvimi/src/repository/utils/screen_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../config/appColors.dart';
import '../../../config/font_size.dart';
import '../../../repository/constants/text_styles.dart';
import '../../../repository/providers/times_provider.dart';
import '../../../repository/utils/app_padding.dart';

class MasjidsPage extends StatefulHookConsumerWidget {
  const MasjidsPage({super.key});

  @override
  ConsumerState<MasjidsPage> createState() => _MasjidsPageState();
}

class _MasjidsPageState extends ConsumerState<MasjidsPage> {
  Position? currentLocation;
  late bool servicePermission;
  late LocationPermission permission;
  final MapController _controller = MapController();
  double zoom = 10;

  Future<Position> getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {}
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }


Future<void> launchMap({
    required double lat,required double lng
})async{
    try{
MapsLauncher.launchCoordinates(lat, lng);
    }catch(e,st){
      log( e.toString(),stackTrace: st);
    }
}
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(distanceProvider);


    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100.h),
        child: Container(
          padding: Dis.only(lr: 8.w, top: 40.h),
          decoration: BoxDecoration(
            color: AppColors.mainGreen,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "near_masjids",
              style: AppTextStyle.instance.w700.copyWith(
                fontSize: FontSizeConst.instance.extraLargeFont,
                color: AppColors.whiteColor,
              ),
            ).tr(),
          ),
        ),
      ),
      body: provider.when(data: (data) {
        return FlutterMap(
            mapController: _controller,
            options: MapOptions(
              minZoom: 9,
              maxZoom: 19,
              keepAlive: true,
              initialCenter:  LatLng(
                currentLocation?.latitude ?? 0,
                currentLocation?.longitude ?? 0,
              ),
              initialZoom: zoom,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              ),
              for (final item in data)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        item!.lat,
                        item.long,
                      ),
                      child: GestureDetector(
                        onTap: () {
                       launchMap(lat: item.lat, lng: item.long, );
                        },
                        child: SvgPicture.asset(
                          "assets/svg/mosque-_1_ 3.svg",
                          height: 26.h,
                          width: 26.w,
                        ),
                      ),
                    ),
                  ],
                ),
               MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      currentLocation?.latitude ?? 0,
                      currentLocation?.longitude ?? 0,
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Colors.red,
                      size: 31,
                    ),
                  ),
                ],
              )
            ]);
      }, error: (error, st) {
        return Text(error.toString(),);
      }, loading: () {
        log("waiting");
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainGreen,
        child: SvgPicture.asset("assets/svg/target-03.svg"),
        onPressed: () async {
          currentLocation = await getCurrentLocation();
          setState(() {
            zoom = 16;
          });
          _controller.move(
               LatLng(

                currentLocation?.latitude ?? 0,
                currentLocation?.longitude ?? 0,
              ),
              zoom);
          log("$currentLocation");
        },
      ),
    );
  }
}
