import 'dart:math';

class GeoCalculator {
  static const double earthRadiusMeters = 6371000.0;

  static double calculateDistance({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusMeters * c;
  }

  static double _toRadians(double degree) {
    return degree * (pi / 180.0);
  }

  static String formatCoordinate(double lat, double lon) {
    final latDir = lat >= 0 ? 'N' : 'S';
    final lonDir = lon >= 0 ? 'E' : 'W';
    return '${lat.abs().toStringAsFixed(4)}° $latDir, ${lon.abs().toStringAsFixed(4)}° $lonDir';
  }

  static String formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    } else {
      final km = meters / 1000.0;
      return '${km.toStringAsFixed(2)} km';
    }
  }

  static String evaluateAccuracy(double accuracyMeters) {
    if (accuracyMeters <= 10) {
      return 'Sangat Akurat (Tinggi)';
    } else if (accuracyMeters <= 30) {
      return 'Cukup Akurat (Sedang)';
    } else {
      return 'Kurang Akurat (Rendah)';
    }
  }
}
