import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_barbershop/screen/Qris.dart'; // QRIS screen

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  // Fungsi untuk menyimpan pesanan ke Firestore beserta email user
  Future<void> _saveOrderToFirestore(String title, String price, String image) async {
    final user = FirebaseAuth.instance.currentUser;
    final ordersCollection = FirebaseFirestore.instance.collection('orders');

    String userEmail = user?.email ?? 'tidak diketahui';

    final docRef = ordersCollection.doc(); // generate ID otomatis

    await docRef.set({
      'id_pesanan': docRef.id,
      'user_email': userEmail,
      'user_id': user?.uid,
      'title': title,
      'price': price,
      'image': image,
      'status': 'waiting_payment',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  // Navigasi ke halaman QRIS setelah menyimpan pesanan
  void _navigateToQRPayment(BuildContext context, String title, String price, String image) async {
    await _saveOrderToFirestore(title, price, image);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(serviceName: title, price: price),
      ),
    );
  }

  // Kartu produk
  Widget _buildProductCard(String title, String price, String imagePath, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      color: Colors.grey[900],
      child: Column(
        children: [
          Expanded(
            child: imagePath.startsWith("http")
                ? Image.network(imagePath, fit: BoxFit.cover)
                : Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  "Rp $price",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _navigateToQRPayment(context, title, price, imagePath),
                  child: const Text("Beli"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // UI utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Produk", style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text('Belum ada produk.', style: TextStyle(color: Colors.white)),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              itemCount: docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;

                final title = data['title'] ?? 'Produk';
                final price = data['price'] ?? '-';
                final image = data['image'] ?? 'assets/default.png';

                return _buildProductCard(title, price, image, context);
              },
            ),
          );
        },
      ),
    );
  }
}
