import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String serviceName;
  final String price;

  const PaymentScreen({super.key, required this.serviceName, required this.price});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? qrData;

  @override
  void initState() {
    super.initState();
    qrData = "Nama: ${widget.serviceName}, Jumlah: ${widget.price}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QRIS Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pembayaran ${widget.serviceName}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            if (qrData != null)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: QrImageView(
                      data: qrData!,
                      size: 200,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Jumlah: ${widget.price}"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Kembali"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
