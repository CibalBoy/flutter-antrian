import 'package:flutter/material.dart';
import '../services/queue_service.dart';

class TakeNumberScreen extends StatefulWidget {
  const TakeNumberScreen({super.key});

  @override
  State<TakeNumberScreen> createState() => _TakeNumberScreenState();
}

class _TakeNumberScreenState extends State<TakeNumberScreen> {
  final QueueService _queueService = QueueService();
  int? myNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ambil Nomor Antrian")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myNumber != null
                ? Text(
                    "Nomor antrian Anda: $myNumber",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                : const Text("Klik tombol untuk ambil nomor"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  myNumber = _queueService.takeNumber();
                });
              },
              child: const Text("Ambil Nomor"),
            ),
          ],
        ),
      ),
    );
  }
}
