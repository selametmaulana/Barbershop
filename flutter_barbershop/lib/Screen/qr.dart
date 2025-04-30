import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class QrScreen extends StatefulWidget {
  final String name;
  final String price;
  final String idBooking;

  const QrScreen({
    super.key,
    required this.name,
    required this.price,
    required this.idBooking,
  });

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  late Timer _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = const Duration(minutes: 2); // Set awal countdown 10 menit
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 0) {
        timer.cancel();
        // Close the screen when the timer reaches zero
        Navigator.pop(context);
      } else {
        setState(() {
          _remaining = _remaining - const Duration(seconds: 1);
        });
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String qrData =
        'ID Booking: ${widget.idBooking}\nNama: ${widget.name}\nJumlah: Rp${widget.price}';

    return Scaffold(
      backgroundColor: const Color(0xFF121117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121117),
        foregroundColor: Colors.white,
        title: const Text('QR Code'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "QRIS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 150,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Text("ID Booking : ${widget.idBooking}", style: const TextStyle(color: Colors.white)),
                    Text("Nama : ${widget.name}", style: const TextStyle(color: Colors.white)),
                    Text("Jumlah Pembayaran : ${widget.price}", style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    Text(
                      "Waktu tersisa: ${formatDuration(_remaining)}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // aksi cek pembayaran
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Cek Pembayaran"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text("Batalkan"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
