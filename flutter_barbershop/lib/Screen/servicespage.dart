import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'biodata.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Layanan Barbershop")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildServiceCard(context, "Potong Rambut", "Rp.50.000", Icons.content_cut),
                  _buildServiceCard(context, "Shaving jenggot & kumis", "Rp.10.000", Icons.face),
                  _buildServiceCard(context, "Creambath", "Rp.30.000", Icons.spa),
                  _buildServiceCard(context, "Hair Coloring", "Rp.80.000", Icons.brush),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String price,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        final String idBooking = DateTime.now().millisecondsSinceEpoch.toString();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BiodataPage(
              service: title,
              price: price,
              idBooking: idBooking,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.blueAccent),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(price, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
