import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_client_front/common/component/container/responsive_container.dart';
import 'package:flutter_client_front/common/styles/sizes.dart';
import 'package:flutter_client_front/common/styles/text_styles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithMarkerAndCircle extends StatefulWidget {
  const MapWithMarkerAndCircle({Key? key}) : super(key: key);

  @override
  _MapWithMarkerAndCircleState createState() => _MapWithMarkerAndCircleState();
}

class _MapWithMarkerAndCircleState extends State<MapWithMarkerAndCircle> {
  final double futsalLng = 128.38939758221701;
  final double futsalLat = 36.145941346142415;
  final double radius = 100;
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  bool isInsideCircle = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: kIconLargeSize * 17,
          height: kIconLargeSize * 17,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.transparent),
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(futsalLat, futsalLng),
              zoom: 16,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              setState(() {
                _addCircle(LatLng(futsalLat, futsalLng), radius);

                _getUserLocation();
              });
            },
            markers: markers,
            circles: circles,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: kPaddingXLargeSize,
          ),
          child: const Text(
            "풋살장 참석 여부를 \n확인하시겠습니까?",
            style: kTextMainStyle,
          ),
        )
        // ElevatedButton(
        //   onPressed: () {
        //     if (isInsideCircle) {
        //       // 원 안에 있을 때 수행할 작업 추가
        //       print('Inside Circle');
        //     } else {
        //       // 원 밖에 있을 때 수행할 작업 추가
        //       print('Outside Circle');
        //     }
        //   },
        //   child: const Text('확인'),
        // ),
      ],
    );
  }

  void _addMarker(LatLng location, String title) {
    markers.add(
      Marker(
        markerId: const MarkerId('marker_1'),
        position: location,
        infoWindow: InfoWindow(
          title: title,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  void _addCircle(LatLng center, double radius) {
    circles.add(
      Circle(
          circleId: const CircleId('circle_1'),
          center: center,
          radius: radius,
          fillColor: Colors.grey.withOpacity(0.3),
          strokeWidth: 1,
          strokeColor: Colors.grey),
    );
  }

  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    bool inside = _isInsideCircle(LatLng(position.latitude, position.longitude),
        LatLng(futsalLat, futsalLng), radius);

    setState(() {
      isInsideCircle = inside;
      markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: '내 위치'),
        ),
      );
    });

    mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
  }

  bool _isInsideCircle(
      LatLng userPosition, LatLng circleCenter, double radiusInMeters) {
    double distance = distanceInMeters(userPosition, circleCenter);
    return distance <= radiusInMeters;
  }

// 위도와 경도의 차이를 미터로 변환하는 함수
  double distanceInMeters(LatLng latLng1, LatLng latLng2) {
    const double earthRadius = 6378137; // 지구의 반지름 (미터)
    double dLat = _degreesToRadians(latLng2.latitude - latLng1.latitude);
    double dLng = _degreesToRadians(latLng2.longitude - latLng1.longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(latLng1.latitude)) *
            cos(_degreesToRadians(latLng2.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

// 각도를 라디안으로 변환하는 함수
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
