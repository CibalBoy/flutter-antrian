import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/queue_provider.dart';

class QueueStatusScreen extends StatefulWidget {
  const QueueStatusScreen({super.key});

  @override
  State<QueueStatusScreen> createState() => _QueueStatusScreenState();
}

class _QueueStatusScreenState extends State<QueueStatusScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<QueueProvider>(context, listen: false).loadQueue();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QueueProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Status Antrian')),
      body: Center(
        child: provider.loading
            ? const CircularProgressIndicator()
            : provider.queue == null
                ? Text(provider.error ?? 'Tidak ada data')
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Nomor Saat Ini', style: TextStyle(fontSize: 16)),
                      Text('${provider.queue!.currentNumber}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Text('Nomor Terakhir: ${provider.queue!.lastNumber}'),
                      const SizedBox(height: 12),
                      Text('Estimasi waktu tiap pasien: ${provider.queue!.estimatedPerPatientMinutes} menit'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          provider.loadQueue();
                        },
                        child: const Text('Refresh'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
