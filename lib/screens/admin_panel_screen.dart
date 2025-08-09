import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/queue_provider.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<QueueProvider>(context, listen: false).loadQueue();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QueueProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Petugas')),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  if (provider.queue != null) ...[
                    Text('Nomor Saat Ini', style: const TextStyle(fontSize: 16)),
                    Text('${provider.queue!.currentNumber}', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final ok = await provider.callNext();
                        if (!ok && provider.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.error!)));
                        }
                      },
                      icon: const Icon(Icons.skip_next),
                      label: const Text('Panggil Nomor Berikutnya'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => provider.loadQueue(),
                      child: const Text('Refresh'),
                    ),
                  ] else
                    Text(provider.error ?? 'Tidak ada data'),
                ],
              ),
            ),
    );
  }
}
