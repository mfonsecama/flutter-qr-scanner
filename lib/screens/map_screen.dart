import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scanner/models/scan_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  MapType _mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _initialPoint =
        CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 40);

    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
        markerId: const MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(_initialPoint));
              },
              icon: const Icon(Icons.location_searching))
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: _mapType,
        markers: markers,
        initialCameraPosition: _initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_mapType == MapType.normal) {
            _mapType = MapType.satellite;
          } else {
            _mapType = MapType.normal;
          }
          setState(() {});
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
