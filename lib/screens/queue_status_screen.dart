import 'package:flutter/material.dart';
import '../services/queue_service.dart';

class QueueStatusScreen extends StatefulWidget {
  const QueueStatusScreen({super.key});

  @override
  State<QueueStatusScreen> createState() => _QueueStatusScreenState();
}

class _QueueStatusScreenState extends State<QueueStatusScreen> {
  final QueueService _queueService = QueueService();

  @override
  Widget build(BuildContext context) {
    var queue = _queueService.getQueue();
    return Scaffold(
      appBar: AppBar(title: const Text("Status Antrian")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nomor saat ini: ${queue.currentNumber}",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Nomor terakhir: ${queue.lastNumber}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _queueService.nextNumber();
                });
              },
              child: const Text("Panggil Nomor Berikutnya"),
            )
          ],
        ),
      ),
    );
  }
}
