import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocation extends StatefulWidget {
  @override
  State<ChooseLocation> createState() => ChooseLocationState();
}

class ChooseLocationState extends State<ChooseLocation> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = Set<Marker>();
  @override
  void initState() {
    super.initState();
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

  LatLng getLast() {
    if (_markers.isNotEmpty)
      return _markers.last.position;
    else {
      setMarker(LatLng(26.307553, 50.146709));
      return LatLng(26.307553, 50.146709);
    }
  }

  static final CameraPosition _startCamera = CameraPosition(
    target: LatLng(26.307553, 50.146709),
    zoom: 14.5,
  );

  void _popFunction(BuildContext context, dynamic result) {
    Navigator.pop(context, result);
  }

  Future<void> moveCamera(LatLng point) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: point,
      zoom: 14.5,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _popFunction(context, _markers.last);
        moveCamera(_markers.last.position);
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _popFunction(context, _markers.last);
            moveCamera(_markers.last.position);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.check),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: SizedBox(
          height: MediaQuery.of(context).size.longestSide,
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
            initialCameraPosition: CameraPosition(
              target: getLast(),
              zoom: 14.5,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onLongPress: setMarker,
          ),
        ),
      ),
    );
  }
}
