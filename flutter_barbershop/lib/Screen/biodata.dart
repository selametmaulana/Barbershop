import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'table_calendar_screen.dart';

class BiodataPage extends StatefulWidget {
  final String service;
  final String price;
  final String idBooking;

  const BiodataPage({
    super.key,
    required this.service,
    required this.price,
    required this.idBooking,
  });

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  late final TextEditingController serviceController;
  final TextEditingController aiHairstyleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    serviceController = TextEditingController(text: widget.service);
  }

  @override
  void dispose() {
    namaController.dispose();
    noHpController.dispose();
    serviceController.dispose();
    aiHairstyleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121117),
      appBar: AppBar(
        title: const Text("Isi Biodata"),
        backgroundColor: const Color(0xFF121117),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2C2C),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "ID Booking: ${widget.idBooking}",
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 15),
                _buildInputField("Nama :", namaController),
                const SizedBox(height: 15),
                _buildInputField("No Handphone :", noHpController),
                const SizedBox(height: 15),
                _buildInputField("Service yang dipilih :", serviceController),
                const SizedBox(height: 15),
                _buildInputField("AI Hairstyle :", aiHairstyleController),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (namaController.text.isEmpty ||
              noHpController.text.isEmpty ||
              serviceController.text.isEmpty ||
              aiHairstyleController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Mohon lengkapi semua data")),
            );
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TableCalendarScreen(
                name: namaController.text,
                phone: noHpController.text,
                service: serviceController.text,
                product: aiHairstyleController.text,
                price: widget.price,
                idBooking: widget.idBooking,  // Pass the idBooking
              ),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ],
    );
  }
}
