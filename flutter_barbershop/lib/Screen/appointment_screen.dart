import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'qris_payment_screen.dart'; // Pastikan file ini sudah ada

class AppointmentScreen extends StatelessWidget {
  final String idBooking;
  final String name;
  final String phone;
  final String service;
  final String product;
  final String price;
  final String bookingDate;
  final String time;

  const AppointmentScreen({
    super.key,
    required this.idBooking,
    required this.name,
    required this.phone,
    required this.service,
    required this.product,
    required this.price,
    required this.bookingDate,
    required this.time,
  });

  Future<void> _confirmAppointmentAndGoToPayment(BuildContext context) async {
    try {
      // Pastikan FirebaseFirestore sudah diimpor
      await FirebaseFirestore.instance.collection('appointments').doc(idBooking).set({
        'idBooking': idBooking,
        'name': name,
        'phone': phone,
        'service': service,
        'product': product,
        'price': price,
        'date': bookingDate,
        'time': time,
        'status': 'waiting_payment',
        'confirmedAt': FieldValue.serverTimestamp(),
      });

      // Setelah berhasil menyimpan data, lanjutkan ke halaman pembayaran
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QrisPaymentScreen(
            name: name,
            price: price,
            idBooking: idBooking,
          ),
        ),
      );
    } catch (e) {
      // Tangani kesalahan jika ada masalah saat menyimpan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan appointment: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text("APPOINTMENT"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID Booking : $idBooking", style: const TextStyle(color: Colors.white)),
              Text("Nama : $name", style: const TextStyle(color: Colors.white)),
              Text("No Hp : $phone", style: const TextStyle(color: Colors.white)),
              Text("Service : $service", style: const TextStyle(color: Colors.white)),
              Text("Product : $product", style: const TextStyle(color: Colors.white)),
              Text("Price : $price", style: const TextStyle(color: Colors.white)),
              Text("Tanggal Booking : $bookingDate", style: const TextStyle(color: Colors.white)),
              Text("Time : $time", style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _confirmAppointmentAndGoToPayment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Next To Payment!",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
