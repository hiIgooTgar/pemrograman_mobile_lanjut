import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:praktikum_5_igo_pml/clean_architecture/data/data_sources/mahasiswa_data_source.dart';
import 'package:praktikum_5_igo_pml/clean_architecture/data/models/mahasiswa_model.dart';

abstract class MahasiswaRemoteDataSource implements MahasiswaDataSource {}

class MahasiswaRemoteDataSourceImpl implements MahasiswaRemoteDataSource {
  final String baseUrl;
  final http.Client client;

  MahasiswaRemoteDataSourceImpl({
    this.baseUrl = "http://localhost:3000/api/mahasiswa",
    http.Client? client,
  }) : client = client ?? http.Client();

  String _extractError(http.Response response, String defaultMsg) {
    try {
      final body = jsonDecode(response.body);
      if (body is Map && body.containsKey('error')) {
        return body['error'].toString();
      }
      if (body is Map && body.containsKey('message')) {
        return body['message'].toString();
      }
    } catch (_) {}
    return "$defaultMsg (Status: ${response.statusCode})";
  }

  @override
  Future<List<MahasiswaModel>> getAllMahasiswa() async {
    http.Response response;
    try {
      response = await client
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception(
        "Gagal terhubung ke REST API ($baseUrl).\nPastikan backend kampus-api sudah berjalan.",
      );
    }
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((item) => MahasiswaModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw Exception(_extractError(response, "Gagal memuat data"));
  }

  @override
  Future<void> addMahasiswa(MahasiswaModel mahasiswa) async {
    http.Response response;
    try {
      response = await client
          .post(
            Uri.parse(baseUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(mahasiswa.toJson()),
          )
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception("Gagal terhubung ke REST API ($baseUrl): $e");
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(_extractError(response, "Gagal menambahkan data"));
    }
  }

  @override
  Future<void> updateMahasiswa(String nim, MahasiswaModel mahasiswa) async {
    http.Response response;
    try {
      response = await client
          .put(
            Uri.parse("$baseUrl/$nim"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(mahasiswa.toJson()),
          )
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception("Gagal terhubung ke REST API ($baseUrl): $e");
    }
    if (response.statusCode != 200) {
      throw Exception(_extractError(response, "Gagal memperbarui data"));
    }
  }

  @override
  Future<void> deleteMahasiswa(String nim) async {
    http.Response response;
    try {
      response = await client
          .delete(Uri.parse("$baseUrl/$nim"))
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception("Gagal terhubung ke REST API ($baseUrl): $e");
    }
    if (response.statusCode != 200) {
      throw Exception(_extractError(response, "Gagal menghapus data"));
    }
  }

  @override
  Future<List<MahasiswaModel>> searchMahasiswa(String query) async {
    http.Response response;
    try {
      final uri = Uri.parse("$baseUrl/search?query=$query");
      response = await client.get(uri).timeout(const Duration(seconds: 5));
    } catch (e) {
      throw Exception("Gagal terhubung ke REST API untuk pencarian: $e");
    }
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((item) => MahasiswaModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw Exception(_extractError(response, "Gagal mencari data"));
  }
}
