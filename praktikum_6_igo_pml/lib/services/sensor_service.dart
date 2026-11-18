import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  Stream<AccelerometerEvent> get accelerometerEvents {
    return SensorsPlatform.instance.accelerometerEventStream();
  }

  Stream<UserAccelerometerEvent> get userAccelerometerEvents {
    return SensorsPlatform.instance.userAccelerometerEventStream();
  }

  Stream<GyroscopeEvent> get gyroscopeEvents {
    return SensorsPlatform.instance.gyroscopeEventStream();
  }
}
