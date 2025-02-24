import 'dart:convert';
import 'package:http/http.dart' as http;

class MlRepo {
  final String serverIp = "192.168.209.113";
  Future<dynamic> sendSensorData(List<List<double>> sensorData) async {
    if (sensorData.length < 10) return;

    final url = Uri.parse('http://$serverIp:5000/send_data');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'data': sensorData});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final dynamic drivingBehavior = responseData['driving_behavior'];

        print("Driving Behavior: $drivingBehavior");
        // await Future.delayed(Duration(seconds: 2));
        // await _calculateDriverScore();
        return drivingBehavior;
      } else {
        throw Exception('Failed to send data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Function to calculate driver score

  Future<double> calculateDriverScore() async {
    final url = Uri.parse('http://$serverIp:5000/calculate_score');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Check if 'driver_score' key exists in the response
        if (responseData.containsKey('driver_score')) {
          final double driverScore = responseData['driver_score'];
          print("Driver Score: $driverScore%");
          return driverScore;
        } else {
          throw Exception('Driver score not found in response');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to calculate driver score: $e');
    }
  }
}
