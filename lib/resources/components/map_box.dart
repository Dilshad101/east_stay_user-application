import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/utils/services.dart';
import 'package:east_stay/utils/map_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Container map(double dheight, Hotel room) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    height: dheight * .25,
    width: double.maxFinite,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
    child: Stack(
      children: [
        AbsorbPointer(
          absorbing: true,
          child: FlutterMap(
            options: MapOptions(
              initialCenter:
                  getLatLng(room.latitude.toString(), room.longitude),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: MapHelper.urlTemplate,
                additionalOptions: const {
                  "accessToken": MapHelper.accessToken,
                  "id": MapHelper.mapId
                },
              ),
              MarkerLayer(alignment: Alignment.center, markers: [
                Marker(
                  height: 100,
                  width: 100,
                  point: getLatLng(room.latitude.toString(), room.longitude),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 35,
                  ),
                )
              ])
            ],
          ),
        ),
        Positioned(
            right: 10,
            bottom: 10,
            child: InkWell(
              onTap: () async {
                await AppService.openGoogleMaps(
                    room.latitude, double.parse(room.longitude));
              },
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.directions,
                      color: Colors.white,
                      size: 28,
                    ),
                    Text(
                      'Directions',
                      style: AppText.mediumLight,
                    )
                  ],
                ),
              ),
            )),
      ],
    ),
  );
}

LatLng getLatLng(String lat, String lng) {
  final latitude = double.parse(lat);
  final longitude = double.parse(lng);
  return LatLng(latitude, longitude);
}
