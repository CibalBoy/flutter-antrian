import 'package:flutter/foundation.dart';
import '../models/queue_model.dart';
import '../services/queue_service.dart'; 


class QueueProvider with ChangeNotifier {
  QueueModel? _queue;
  bool _loading = false;
  String? _error;

  QueueModel? get queue => _queue;
  bool get loading => _loading;
  String? get error => _error;

  /// Ambil status antrian dari backend
  Future<void> loadQueue() async {
    _loading = true;
    notifyListeners();

    try {
      _queue = await ApiService.fetchQueueStatus();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Ambil nomor antrian baru
  Future<int?> takeNumber({Map<String, dynamic>? body}) async {
    try {
      final number = await ApiService.takeNumber(body: body);
      await loadQueue(); // refresh status setelah ambil nomor
      return number;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  /// Panggil nomor berikutnya (untuk petugas)
  Future<bool> callNext() async {
    try {
      await ApiService.nextNumber();
      await loadQueue();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
