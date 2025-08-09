import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/queue_model.dart';

class ApiService {
  // Ganti baseUrl sesuai backend Laravel-mu, contoh: http://10.0.2.2:8000
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Ambil status antrian
  static Future<QueueModel> fetchQueueStatus() async {
    final url = Uri.parse('$baseUrl/api/queue');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final jsonData = json.decode(res.body);
      return QueueModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load queue status');
    }
  }

  // Ambil nomor antrian baru
  // body bisa berisi data pasien (nama, tipe layanan dll) jika ingin
  static Future<int> takeNumber({Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl/api/queue/take-number');
    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body ?? {}));
    if (res.statusCode == 201 || res.statusCode == 200) {
      final jsonData = json.decode(res.body);
      // backend diharapkan mengembalikan { "number": 5 }
      return jsonData['number'];
    } else {
      throw Exception('Failed to take number');
    }
  }

  // Petugas memanggil nomor berikutnya
  static Future<void> nextNumber() async {
    final url = Uri.parse('$baseUrl/api/queue/next');
    final res = await http.post(url);
    if (res.statusCode != 200) {
      throw Exception('Failed to call next number');
    }
  }
}
