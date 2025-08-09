import 'package:flutter/material.dart';
import 'queue_status_screen.dart';
import 'take_number_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Antrian RS')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TakeNumberScreen()));
              },
              icon: const Icon(Icons.add),
              label: const Text("Ambil Nomor Antrian"),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const QueueStatusScreen()));
              },
              icon: const Icon(Icons.queue),
              label: const Text("Lihat Status Antrian"),
            ),
          ],
        ),
      ),
    );
  }
}
