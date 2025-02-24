import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class SpeedTile extends StatefulWidget {
  const SpeedTile({
    super.key,
  });

  @override
  State<SpeedTile> createState() => _SpeedTileState();
}

class _SpeedTileState extends State<SpeedTile> {
  double _currentSpeed = 0.0;
  bool _isTracking = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return;
    }

    // Start tracking speed
    _startSpeedTracking();
  }

  void _startSpeedTracking() {
    setState(() {
      _isTracking = true;
    });

    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentSpeed = position.speed; // Speed in meters per second
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;

    double dw = MediaQuery.of(context).size.width;
    return Container(
      height: dh * 0.2,
      width: dw * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: dh * 0.08,
                width: dh * 0.08,
                child: Image.asset('assets/png/icons/meter.png')),
            SizedBox(
              height: 10,
            ),
            Text(
              'Speed',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    //! This controls the decimal pointers of speed
                    (_currentSpeed * 3.6).toStringAsFixed(0),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Kmph',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 10),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
