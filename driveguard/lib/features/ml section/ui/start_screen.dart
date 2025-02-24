import 'dart:async';
import 'package:driveguard/features/ml%20section/logic/cubit/sensor_data_cubit_cubit.dart';
import 'package:driveguard/features/ml%20section/ui/widgets/speed_tile.dart';
import 'package:driveguard/features/ml%20section/ui/widgets/start_tile.dart';
import 'package:driveguard/features/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String _drivingBehavior = "Unknown";
  double _driverScore = 0.0;
  bool _isLoading = false;
  List<List<double>> _sensorData = [];

  StreamSubscription? _accelerometerSubscription;
  StreamSubscription? _gyroscopeSubscription;

  // Server IP (Update this with your correct IP)
  final String serverIp = "192.168.209.113";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _startSensorCollection();
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  // Start collecting accelerometer & gyroscope data
  void _startSensorCollection() {
    List<List<double>> tempData = [];

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      if (tempData.length < 10) {
        // Add 14 features (6 from sensors, 8 placeholders)
        tempData
            .add([event.x, event.y, event.z, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      }
    });

    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (tempData.isNotEmpty && tempData.length <= 10) {
        int lastIndex = tempData.length - 1;
        // Update gyroscope data (features 3, 4, 5)
        tempData[lastIndex][3] = event.x;
        tempData[lastIndex][4] = event.y;
        tempData[lastIndex][5] = event.z;
      }

      if (tempData.length == 10) {
        setState(() {
          _sensorData = tempData;
        });
        if (mounted) {
          context.read<SensorDataCubitCubit>().sendSensorData(_sensorData);
        }
        tempData = []; // Reset after sending
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double dh = MediaQuery.of(context).size.height;

    double dw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // _buildIcon('assets/png/icons/hamburger.png'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DriveGuard',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      'Lets Drive Safer',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: const Color.fromARGB(255, 111, 111, 111)),
                    )
                  ],
                ),
                // _buildIcon('assets/png/icons/hamburger.png')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: dh * 0.27,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Image.asset('assets/png/cars/rs7_side.png'),
                      SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<SensorDataCubitCubit, SensorDataCubitState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          if (state is SensorDataFail) {
                            return Text(
                              '${state.error}',
                              style: GoogleFonts.actor(
                                  fontSize: 35,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.green),
                            );
                          }
                          if (state is SensorDataInprogress) {
                            return const CircularProgressIndicator();
                          }
                          if (state is SensorDatasentSuceessState) {
                            return state.behaviour == 'Aggressive Driving'
                                ? Text(
                                    '${state.behaviour}',
                                    style: GoogleFonts.actor(
                                        fontSize: 35,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.red),
                                  )
                                : Text(
                                    '${state.behaviour}',
                                    style: GoogleFonts.actor(
                                        fontSize: 35,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.green),
                                  );
                          }
                          return SizedBox();
                        },
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SpeedTile(),
                SizedBox(
                  width: 20,
                ),
                StartTile(
                    title: 'Status',
                    iconPath: 'assets/png/icons/cloud-computing.png',
                    subText: 'Upload Status')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Expanded(child: SizedBox()),
            CustomSliderButton(
              func: () async {
                Navigator.pop(context);
                return null;
              },
              imagePath: 'assets/png/icons/stop-sign.png',
            ),
          ],
        ),
      ),
    );
  }
}
