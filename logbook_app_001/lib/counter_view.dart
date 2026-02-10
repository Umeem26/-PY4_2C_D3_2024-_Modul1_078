import 'package:flutter/material.dart';
import 'counter_controller.dart'; 

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task 2: History Logger"), // Judul sesuai Task 2
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // Tombol Reset dengan Dialog Konfirmasi (Homework)
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Reset Data',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Reset Data?"),
                  content: const Text("Yakin ingin menghapus semua angka dan riwayat? Data tidak bisa kembali."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Tutup dialog
                        _controller.reset();    // Reset data logika
                        refresh();              // Update tampilan
                        
                        // Tampilkan SnackBar (Pesan konfirmasi)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data berhasil di-reset ke 0!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text("Ya, Hapus", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // --- BAGIAN ATAS: Kontrol Utama (Slider & Angka) ---
          Expanded(
            flex: 2, 
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.grey[50], 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Atur Langkah (Step):", style: TextStyle(color: Colors.grey)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${_controller.step}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  // Slider untuk Task 1
                  Slider(
                    value: _controller.step.toDouble(),
                    min: 1, max: 10, divisions: 9,
                    label: _controller.step.toString(),
                    activeColor: Colors.indigo,
                    onChanged: (val) {
                      _controller.setStep(val.toInt());
                      refresh();
                    },
                  ),
                  
                  const SizedBox(height: 20),

                  // Angka Utama
                  Text(
                    '${_controller.value}',
                    style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),

                  const SizedBox(height: 30),

                  // Tombol Aksi Tambah & Kurang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () { _controller.decrement(); refresh(); },
                        icon: const Icon(Icons.remove),
                        label: const Text("Kurang"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[50],
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () { _controller.increment(); refresh(); },
                        icon: const Icon(Icons.add),
                        label: const Text("Tambah"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[50],
                          foregroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- BAGIAN BAWAH: List Riwayat (Task 2) ---
          Expanded(
            flex: 1, 
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text("Riwayat Aktivitas (Maks 5):", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  
                  // Menampilkan List History
                  Expanded(
                    child: _controller.history.isEmpty
                        ? const Center(child: Text("Belum ada aktivitas.", style: TextStyle(color: Colors.grey)))
                        : ListView.builder(
                            itemCount: _controller.history.length,
                            itemBuilder: (context, index) {
                              final log = _controller.history[index];
                              
                              // Logika warna ikon manual (Tanpa AI canggih)
                              IconData icon = Icons.info;
                              Color color = Colors.blue;
                              
                              if (log.contains("Ditambah")) {
                                icon = Icons.arrow_upward;
                                color = Colors.green;
                              } else if (log.contains("Dikurang")) {
                                icon = Icons.arrow_downward;
                                color = Colors.red;
                              } else if (log.contains("reset")) {
                                icon = Icons.refresh;
                                color = Colors.orange;
                              }

                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                elevation: 0,
                                color: color.withAlpha(30), 
                                child: ListTile(
                                  leading: Icon(icon, color: color),
                                  title: Text(log, style: const TextStyle(fontSize: 14)),
                                  dense: true, 
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}