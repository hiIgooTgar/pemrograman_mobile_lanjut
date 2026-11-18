import 'dart:async';

import 'package:flutter/material.dart';
import 'package:praktikum_6_igo_pml/services/sensor_service.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  final SensorService _sensorService = SensorService();

  StreamSubscription<AccelerometerEvent>? _accelSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroSubscription;

  double _accelX = 0.0;
  double _accelY = 0.0;
  double _accelZ = 0.0;

  double _gyroX = 0.0;
  double _gyroY = 0.0;
  double _gyroZ = 0.0;

  bool _isListening = true;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() {
    _accelSubscription = _sensorService.accelerometerEvents.listen((event) {
      if (!mounted) return;
      setState(() {
        _accelX = event.x;
        _accelY = event.y;
        _accelZ = event.z;
      });
    });

    _gyroSubscription = _sensorService.gyroscopeEvents.listen((event) {
      if (!mounted) return;
      setState(() {
        _gyroX = event.x;
        _gyroY = event.y;
        _gyroZ = event.z;
      });
    });
  }

  void _toggleListening() {
    setState(() {
      if (_isListening) {
        _accelSubscription?.pause();
        _gyroSubscription?.pause();
        _isListening = false;
      } else {
        _accelSubscription?.resume();
        _gyroSubscription?.resume();
        _isListening = true;
      }
    });
  }

  @override
  void dispose() {
    _accelSubscription?.cancel();
    _gyroSubscription?.cancel();
    super.dispose();
  }

  String _getTiltDescription() {
    if (_accelX.abs() < 1.0 && _accelY.abs() < 1.0 && _accelZ > 8.0) {
      return 'Perangkat Datar di Meja (Flat)';
    } else if (_accelX > 2.0) {
      return 'Miring ke Sisi Kiri';
    } else if (_accelX < -2.0) {
      return 'Miring ke Sisi Kanan';
    } else if (_accelY > 5.0) {
      return 'Perangkat Dipegang Tegak (Portrait)';
    } else if (_accelY < -5.0) {
      return 'Perangkat Posisi Terbalik';
    }
    return 'Kemiringan Dinamis';
  }

  @override
  Widget build(BuildContext context) {
    final double maxOffset = 55.0;
    final double bubbleX = (-_accelX * 6.0).clamp(-maxOffset, maxOffset);
    final double bubbleY = (_accelY * 6.0).clamp(-maxOffset, maxOffset);
    final bool isLevel = (_accelX.abs() < 0.6) && (_accelY.abs() < 0.6);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Hardware'),
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.pause : Icons.play_arrow),
            tooltip: _isListening ? 'Jeda Sensor' : 'Mulai Sensor',
            onPressed: _toggleListening,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Visualisasi Waterpas (Spirit Level)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _getTiltDescription(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isLevel ? Colors.green : Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isLevel
                            ? Colors.green.shade50
                            : Colors.indigo.shade50,
                        border: Border.all(
                          color: isLevel
                              ? Colors.green
                              : Colors.indigo.shade300,
                          width: 3,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black26,
                                width: 1.5,
                              ),
                            ),
                          ),
                          Divider(color: Colors.black12, thickness: 1),
                          VerticalDivider(color: Colors.black12, thickness: 1),
                          Transform.translate(
                            offset: Offset(bubbleX, bubbleY),
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isLevel ? Colors.green : Colors.indigo,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 4,
                                    offset: const Offset(1, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isLevel
                          ? '✅ Posisi Datar Sempurna!'
                          : 'Gerakkan ponsel untuk menyeimbangkan gelembung.',
                      style: TextStyle(
                        fontSize: 11,
                        color: isLevel ? Colors.green : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.speed, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text(
                          'Akselerometer (Percepatan m/s²)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    _buildAxisIndicator(
                      'Sumbu X (Kiri - Kanan)',
                      _accelX,
                      Colors.red,
                    ),
                    _buildAxisIndicator(
                      'Sumbu Y (Bawah - Atas)',
                      _accelY,
                      Colors.green,
                    ),
                    _buildAxisIndicator(
                      'Sumbu Z (Depan - Belakang)',
                      _accelZ,
                      Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.rotate_right, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'Giroskop (Kecepatan Sudut rad/s)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    _buildAxisIndicator(
                      'Putaran X (Pitch)',
                      _gyroX,
                      Colors.red,
                    ),
                    _buildAxisIndicator(
                      'Putaran Y (Roll)',
                      _gyroY,
                      Colors.green,
                    ),
                    _buildAxisIndicator('Putaran Z (Yaw)', _gyroZ, Colors.blue),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAxisIndicator(String label, double value, Color barColor) {
    final double normalized = ((value + 10.0) / 20.0).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12)),
              Text(
                '${value >= 0 ? '+' : ''}${value.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: normalized,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ],
      ),
    );
  }
}
