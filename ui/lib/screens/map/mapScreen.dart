import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  // GoogleMapController _googleMapController;
  // Marker _origin;
  // Marker _destination;
  // Directions _info;

  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polylineIdCounter = 1;

  static final CameraPosition _kfupmCamera = CameraPosition(
    target: LatLng(26.307553, 50.146709),
    zoom: 14.5,
  );

  static final Polyline _kPolyline = Polyline(
    polylineId: PolylineId('_kPolyline'),
    points: [
      LatLng(26.307553, 50.146709),
      LatLng(26.335784377734086, 50.120961846856744),
    ],
    width: 2,
  );

  @override
  void initState() {
    super.initState();

    chooseLocation(LatLng(26.307553, 50.146709));
  }

  void chooseLocation(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('_name'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta),
          position: point,
        ),
      );
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.longestSide,
        child: GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          polylines: _polylines,
          gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()),
            )
            ..add(
              Factory<HorizontalDragGestureRecognizer>(
                  () => HorizontalDragGestureRecognizer()),
            )
            ..add(
              Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
            ),
          initialCameraPosition: _kfupmCamera,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onLongPress: chooseLocation,
        ),
      ),
    );
  }
}
