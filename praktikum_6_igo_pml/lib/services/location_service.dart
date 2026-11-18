import 'package:geolocator/geolocator.dart';
import 'package:praktikum_6_igo_pml/utils/geo_calculator.dart';

class LocationService {
  static const double referenceLat = -6.175392;
  static const double referenceLon = 106.827153;
  static const String referenceName = "Monumen Nasional (Monas), Jakarta";

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> handlePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(
        'Layanan GPS (Location Service) di perangkat sedang nonaktif.',
      );
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Izin akses lokasi ditolak oleh pengguna.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Izin lokasi ditolak permanen. Buka pengaturan untuk mengizinkan.',
      );
    }

    return permission;
  }

  Future<Position> getCurrentLocation() async {
    await handlePermission();
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      ),
    );
  }

  double calculateDistanceToReference(Position userPosition) {
    return GeoCalculator.calculateDistance(
      lat1: userPosition.latitude,
      lon1: userPosition.longitude,
      lat2: referenceLat,
      lon2: referenceLon,
    );
  }

  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }
}
