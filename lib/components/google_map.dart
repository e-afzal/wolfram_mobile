import 'package:flutter/material.dart';

// THIRD PARTY PACKAGES
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertiesMap extends StatefulWidget {
  @override
  State<PropertiesMap> createState() => PropertiesMapState();
  final lat;
  final long;
  PropertiesMap({this.lat, this.long});
}

class PropertiesMapState extends State<PropertiesMap> {
  var _initialCameraPosition;
  @override
  void initState() {
    super.initState();
    setState(() {
      _initialCameraPosition = CameraPosition(
          target: LatLng(widget.lat, widget.long),
          // zoom is 0 - 21. 21 being highest zoom
          zoom: 16.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 225,
      child: GoogleMap(
        scrollGesturesEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        markers: <Marker>{
          Marker(
              markerId: MarkerId('1'),
              position: LatLng(widget.lat, widget.long))
        },
      ),
    );
  }
}
