import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:praktikum_6_igo_pml/services/permission_service.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  final PermissionService _service = PermissionService();

  PermissionStatus _cameraStatus = PermissionStatus.denied;
  PermissionStatus _locationStatus = PermissionStatus.denied;
  PermissionStatus _storageStatus = PermissionStatus.denied;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshStatuses();
  }

  Future<void> _refreshStatuses() async {
    setState(() => _isLoading = true);
    final cam = await _service.checkStatus(Permission.camera);
    final loc = await _service.checkStatus(Permission.location);
    final storage = await _service.checkStatus(Permission.photos);

    setState(() {
      _cameraStatus = cam;
      _locationStatus = loc;
      _storageStatus = storage;
      _isLoading = false;
    });
  }

  Future<void> _request(Permission permission) async {
    final status = await _service.requestPermission(permission);
    await _refreshStatuses();

    if (mounted) {
      if (status == PermissionStatus.permanentlyDenied) {
        _showPermanentlyDeniedDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Status Izin: ${PermissionService.getStatusLabel(status)}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showPermanentlyDeniedDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Izin Ditolak Permanen'),
        content: const Text(
          'Izin ini telah ditolak secara permanen oleh sistem. Anda perlu membukanya secara manual di menu Pengaturan Aplikasi.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _service.openSettings();
            },
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(PermissionStatus status) {
    if (PermissionService.isGranted(status)) return Colors.green;
    if (status == PermissionStatus.permanentlyDenied) return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Runtime Permissions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Perbarui Status',
            onPressed: _refreshStatuses,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshStatuses,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.blue.shade200),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Icon(Icons.security, color: Colors.blue, size: 32),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Runtime Permissions meminta persetujuan pengguna saat fitur perangkat keras dibutuhkan, menjaga privasi dan keamanan sistem.',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPermissionCard(
                    title: 'Izin Kamera (Camera)',
                    subtitle:
                        'Dibutuhkan untuk memotret atau merekam video langsung.',
                    icon: Icons.camera_alt_outlined,
                    status: _cameraStatus,
                    onTapRequest: () => _request(Permission.camera),
                  ),
                  const SizedBox(height: 12),
                  _buildPermissionCard(
                    title: 'Izin Lokasi (GPS)',
                    subtitle:
                        'Dibutuhkan untuk membaca koordinat lintang & bujur perangkat.',
                    icon: Icons.location_on_outlined,
                    status: _locationStatus,
                    onTapRequest: () => _request(Permission.location),
                  ),
                  const SizedBox(height: 12),
                  _buildPermissionCard(
                    title: 'Izin Media / Foto (Storage)',
                    subtitle:
                        'Dibutuhkan untuk membaca atau memilih gambar dari galeri.',
                    icon: Icons.photo_library_outlined,
                    status: _storageStatus,
                    onTapRequest: () => _request(Permission.photos),
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () => _service.openSettings(),
                    icon: const Icon(Icons.settings),
                    label: const Text(
                      'Buka Pengaturan Aplikasi (App Settings)',
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildPermissionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required PermissionStatus status,
    required VoidCallback onTapRequest,
  }) {
    final color = _getStatusColor(status);
    final isGranted = PermissionService.isGranted(status);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.15),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    PermissionService.getStatusLabel(status),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  backgroundColor: color.withValues(alpha: 0.1),
                  side: BorderSide(color: color.withValues(alpha: 0.3)),
                ),
                ElevatedButton.icon(
                  onPressed: isGranted ? null : onTapRequest,
                  icon: Icon(
                    isGranted ? Icons.check : Icons.lock_open,
                    size: 16,
                  ),
                  label: Text(isGranted ? 'Sudah Aktif' : 'Minta Izin'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isGranted
                        ? Colors.grey.shade300
                        : Colors.indigo,
                    foregroundColor: isGranted ? Colors.black54 : Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
