import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:praktikum_6_igo_pml/services/location_service.dart';
import 'package:praktikum_6_igo_pml/utils/geo_calculator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final LocationService _locationService = LocationService();
  Position? _currentPosition;
  double? _distanceToRef;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final pos = await _locationService.getCurrentLocation();
      final dist = _locationService.calculateDistanceToReference(pos);
      setState(() {
        _currentPosition = pos;
        _distanceToRef = dist;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation (GPS)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: 'Perbarui Lokasi',
            onPressed: _isLoading ? null : _fetchLocation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _fetchLocation,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.gps_fixed),
              label: Text(
                _isLoading
                    ? 'Membaca Satelit GPS...'
                    : 'Ambil Koordinat GPS Saat Ini',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            if (_errorMessage != null)
              Card(
                color: Colors.red.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.red.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.location_off,
                        color: Colors.red,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () =>
                            _locationService.openLocationSettings(),
                        icon: const Icon(Icons.settings),
                        label: const Text('Buka Pengaturan Lokasi'),
                      ),
                    ],
                  ),
                ),
              ),

            if (_currentPosition != null) ...[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Koordinat Perangkat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Chip(
                            label: Text(
                              GeoCalculator.evaluateAccuracy(
                                _currentPosition!.accuracy,
                              ),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.green.shade50,
                            side: BorderSide(color: Colors.green.shade300),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      _buildCoordinateItem(
                        icon: Icons.explore,
                        label: 'Format Standar (DMS)',
                        value: GeoCalculator.formatCoordinate(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildCoordinateItem(
                        icon: Icons.north,
                        label: 'Latitude (Lintang)',
                        value: _currentPosition!.latitude.toStringAsFixed(7),
                      ),
                      const SizedBox(height: 12),
                      _buildCoordinateItem(
                        icon: Icons.east,
                        label: 'Longitude (Bujur)',
                        value: _currentPosition!.longitude.toStringAsFixed(7),
                      ),
                      const SizedBox(height: 12),
                      _buildCoordinateItem(
                        icon: Icons.height,
                        label: 'Ketinggian (Altitude)',
                        value:
                            '${_currentPosition!.altitude.toStringAsFixed(1)} meter dpl',
                      ),
                      const SizedBox(height: 12),
                      _buildCoordinateItem(
                        icon: Icons.radar,
                        label: 'Radius Akurasi GPS',
                        value:
                            '± ${_currentPosition!.accuracy.toStringAsFixed(1)} meter',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Card(
                elevation: 1,
                color: Colors.indigo.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.indigo.shade100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Kalkulasi Jarak (Haversine Formula)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Jarak garis lurus dari posisi Anda ke titik acuan:',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const Divider(height: 16),
                      Text(
                        LocationService.referenceName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.straighten, color: Colors.indigo),
                          const SizedBox(width: 8),
                          Text(
                            _distanceToRef != null
                                ? GeoCalculator.formatDistance(_distanceToRef!)
                                : '-',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (!_isLoading && _errorMessage == null)
              Container(
                height: 260,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_searching,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tekan tombol di atas untuk membaca GPS',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoordinateItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.black54),
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
