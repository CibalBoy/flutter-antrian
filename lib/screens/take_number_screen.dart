import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/queue_provider.dart';

class TakeNumberScreen extends StatefulWidget {
  const TakeNumberScreen({super.key});

  @override
  State<TakeNumberScreen> createState() => _TakeNumberScreenState();
}

class _TakeNumberScreenState extends State<TakeNumberScreen> {
  bool _loading = false;
  int? myNumber;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QueueProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Ambil Nomor Antrian')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            if (myNumber != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    const Text('Nomor Antrian Anda', style: TextStyle(fontSize: 16)),
                    Text('$myNumber', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading
                  ? null
                  : () async {
                      setState(() {
                        _loading = true;
                      });
                      final number = await provider.takeNumber(body: {
                        // jika mau sertakan nama/layanan tambahkan field di sini
                        'service': 'Poliklinik Umum'
                      });
                      setState(() {
                        myNumber = number;
                        _loading = false;
                      });
                    },
              child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Ambil Nomor Sekarang'),
            ),
            const SizedBox(height: 24),
            const Text('Catatan: Simpan nomor untuk ditunjukkan ke petugas saat dipanggil.'),
          ],
        ),
      ),
    );
  }
}
