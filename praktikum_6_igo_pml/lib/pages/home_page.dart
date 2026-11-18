import 'package:flutter/material.dart';
import 'package:praktikum_6_igo_pml/pages/camera_page.dart';
import 'package:praktikum_6_igo_pml/pages/location_page.dart';
import 'package:praktikum_6_igo_pml/pages/permission_page.dart';
import 'package:praktikum_6_igo_pml/pages/sensor_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 06: Hardware & Testing'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            color: Colors.indigo.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.indigo.shade100),
            ),
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.developer_board,
                        color: Colors.indigo,
                        size: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Integrasi Fitur Perangkat Keras',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Modul ini mendemonstrasikan akses perangkat keras (Hardware Features), manajemen izin runtime (Permissions), serta pengujian otomatis (Unit & Widget Test).',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'PILIH MODUL PRAKTIKUM:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),

          _buildFeatureCard(
            context,
            icon: Icons.security,
            iconColor: Colors.deepPurple,
            title: '1. Runtime Permissions',
            subtitle: 'Pemeriksaan status izin, dialog permintaan izin runtime, dan akses ke Pengaturan Aplikasi.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PermissionPage()),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildFeatureCard(
            context,
            icon: Icons.camera_alt,
            iconColor: Colors.blue,
            title: '2. Akses Kamera & Galeri',
            subtitle: 'Mengambil foto dari kamera fisik, memilih gambar dari galeri, dan menampilkan detail berkas.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CameraPage()),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildFeatureCard(
            context,
            icon: Icons.location_on,
            iconColor: Colors.red,
            title: '3. Geolocation (GPS)',
            subtitle: 'Membaca titik koordinat satelit GPS, radius akurasi, dan menghitung jarak geografis.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationPage()),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildFeatureCard(
            context,
            icon: Icons.screen_rotation,
            iconColor: Colors.teal,
            title: '4. Sensor Akselerometer & Giroskop',
            subtitle: 'Stream sensor orientasi fisik dan visualisasi animasi waterpas (spirit level).',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SensorPage()),
              );
            },
          ),
          const SizedBox(height: 16),

          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                child: Icon(Icons.rule),
              ),
              title: const Text(
                '5. Unit & Widget Testing',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Pengujian otomatis logika & komponen UI. Klik untuk info pengujian.',
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.info_outline, color: Colors.green),
              onTap: () => _showTestingDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: iconColor.withValues(alpha: 0.15),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
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
              const Icon(Icons.chevron_right, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }

  void _showTestingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 8),
            Text('Unit & Widget Test'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modul ini dilengkapi dengan berkas pengujian otomatis:',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 8),
            Text(
              '• test/pertemuan_06/unit_test/ (Formula Haversine & Formatter)',
            ),
            Text(
              '• test/pertemuan_06/widget_test/ (Render UI & Menu Navigasi)',
            ),
            SizedBox(height: 12),
            Text(
              'Jalankan pengujian melalui terminal:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            SizedBox(height: 4),
            SelectableText(
              'flutter test test/pertemuan_06/',
              style: TextStyle(
                fontFamily: 'monospace',
                backgroundColor: Colors.black12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
