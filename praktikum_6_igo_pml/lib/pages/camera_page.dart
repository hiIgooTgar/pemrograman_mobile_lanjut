import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:praktikum_6_igo_pml/services/camera_service.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final CameraService _cameraService = CameraService();
  XFile? _imageFile;
  int? _fileSizeBytes;
  bool _isLoading = false;

  Future<void> _takePhoto() async {
    setState(() => _isLoading = true);
    try {
      final photo = await _cameraService.takePhoto();
      if (photo != null) {
        final length = await photo.length();
        setState(() {
          _imageFile = photo;
          _fileSizeBytes = length;
        });
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickGallery() async {
    setState(() => _isLoading = true);
    try {
      final image = await _cameraService.pickImageFromGallery();
      if (image != null) {
        final length = await image.length();
        setState(() {
          _imageFile = image;
          _fileSizeBytes = length;
        });
      }
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message.replaceAll('Exception: ', '')),
        backgroundColor: Colors.red,
      ),
    );
  }

  String _formatFileSize(int? bytes) {
    if (bytes == null) return '-';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akses Kamera & Galeri'),
        actions: [
          if (_imageFile != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Hapus Gambar',
              onPressed: () {
                setState(() {
                  _imageFile = null;
                  _fileSizeBytes = null;
                });
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Memproses gambar...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Area Tombol Aksi
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _takePhoto,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Buka Kamera'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _pickGallery,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Buka Galeri'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Area Pratinjau Gambar
                  if (_imageFile == null)
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 72,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada gambar yang diambil',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Gunakan tombol di atas untuk memotret dengan kamera',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  else ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: kIsWeb
                            ? Image.network(_imageFile!.path, fit: BoxFit.cover)
                            : Image.file(
                                File(_imageFile!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Informasi Berkas Gambar:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const Divider(height: 16),
                            _buildInfoRow('Nama Berkas', _imageFile!.name),
                            _buildInfoRow(
                              'Ukuran File',
                              _formatFileSize(_fileSizeBytes),
                            ),
                            _buildInfoRow(
                              'MIME Type',
                              _imageFile!.mimeType ?? 'image/jpeg',
                            ),
                            _buildInfoRow('Lokasi Path', _imageFile!.path),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          const Text(': '),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
