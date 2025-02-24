import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _pGooglrPlex = LatLng(37.4223, -122.0848);
  static const LatLng _applePlex = LatLng(37.336, -122.0090);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _pGooglrPlex, zoom: 17),
        markers: {
          Marker(
              markerId: MarkerId('_currentLocation'),
              icon: BitmapDescriptor.defaultMarker,
              position: _pGooglrPlex),
          Marker(
              markerId: MarkerId('_sourceLocation'),
              icon: BitmapDescriptor.defaultMarker,
              position: _applePlex),
        },
      ),
    );
  }
}
