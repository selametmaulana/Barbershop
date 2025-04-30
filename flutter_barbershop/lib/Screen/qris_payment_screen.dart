import 'package:flutter/material.dart';
import 'qr.dart'; // Pastikan qr.dart ada dan QrScreen sudah dibuat

class QrisPaymentScreen extends StatelessWidget {
  final String name;
  final String price;
  final String idBooking; // Tambahkan idBooking

  const QrisPaymentScreen({
    super.key,
    required this.name,
    required this.price,
    required this.idBooking, // Tambahkan ke konstruktor
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: name);
    final TextEditingController priceController =
        TextEditingController(text: price);

    return Scaffold(
      backgroundColor: const Color(0xFF121117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121117),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text("QRIS Payment"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "QRIS",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nama",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: nameController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: _inputDecoration(),
                    ),
                    const SizedBox(height: 15),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Jumlah Pembayaran",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: priceController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: _inputDecoration(),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman QR
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrScreen(
                              name: name,
                              price: price,
                              idBooking: idBooking, // Kirim juga ke QrScreen
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "Generate QR Code",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}
