import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocationPreview extends StatefulWidget {
  @override
  State<ChooseLocationPreview> createState() => ChooseLocationPreviewState();
}

class ChooseLocationPreviewState extends State<ChooseLocationPreview> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = Set<Marker>();

  static final CameraPosition _startCamera = CameraPosition(
    target: LatLng(26.307553, 50.146709),
    zoom: 14.5,
  );

  @override
  void initState() {
    super.initState();

    setMarker(LatLng(26.307553, 50.146709));
  }

  void setMarker(LatLng point) {
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

  void _popFunction(BuildContext context, dynamic result) {
    Navigator.pop(context, result);
  }

  SizedBox returnMap() {
    return SizedBox(
      height: MediaQuery.of(context).size.longestSide * 0.4,
      width: MediaQuery.of(context).size.shortestSide * 0.4,
      child: AbsorbPointer(
        absorbing: true,
        child: GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
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
          initialCameraPosition: _startCamera,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.longestSide * 0.4,
        width: MediaQuery.of(context).size.shortestSide * 0.4,
        child: AbsorbPointer(
          absorbing: true,
          child: GoogleMap(
            mapType: MapType.normal,
            markers: _markers,
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
            initialCameraPosition: _startCamera,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
        ),
      ),
    );
  }
}
