import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> checkStatus(Permission permission) async {
    return await permission.status;
  }

  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }

  Future<bool> openSettings() async {
    return await openAppSettings();
  }

  static String getStatusLabel(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Diizinkan (Granted)';
      case PermissionStatus.denied:
        return 'Ditolak (Denied)';
      case PermissionStatus.permanentlyDenied:
        return 'Ditolak Permanen (Settings)';
      case PermissionStatus.restricted:
        return 'Dibatasi Sistem (Restricted)';
      case PermissionStatus.limited:
        return 'Terbatas (Limited)';
      case PermissionStatus.provisional:
        return 'Sementara (Provisional)';
    }
  }

  static bool isGranted(PermissionStatus status) {
    return status == PermissionStatus.granted ||
        status == PermissionStatus.limited;
  }
}
