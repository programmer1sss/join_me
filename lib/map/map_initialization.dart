import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapInitialization extends StatelessWidget {
  const MapInitialization({
    Key? key,
    required CameraPosition kGooglePlex,
    required Completer<GoogleMapController> controller,
  }) : _kGooglePlex = kGooglePlex, _controller = controller, super(key: key);

  final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return NewWidget(kGooglePlex: _kGooglePlex, controller: _controller);
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key? key,
    required CameraPosition kGooglePlex,
    required Completer<GoogleMapController> controller,
  }) : _kGooglePlex = kGooglePlex, _controller = controller, super(key: key);

  final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  LatLng? _lastTap;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: widget._kGooglePlex,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      // markers: _markers.values.toSet(),
      // circles: circles.values.toSet(),
      onMapCreated: (GoogleMapController controller) {
        widget._controller.complete(controller);
      },
      onTap: (LatLng pos) {
        setState(() {
          _lastTap = pos;
        });
      },
      markers: <Marker>{
        const Marker(
          markerId: MarkerId('test_marker_id'),
          position: LatLng(37.43111844805164, -122.08069436252116),
          infoWindow: InfoWindow(
            title: 'An interesting location',
            snippet: '*',
          ),
        ),
      },
    );
  }
}


