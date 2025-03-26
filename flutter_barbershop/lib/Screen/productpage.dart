import 'package:flutter/material.dart';
import 'package:flutter_barbershop/screen/Qris.dart';
 // Pastikan file ini ada dan benar

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  void _navigateToQRPayment(BuildContext context, String title, String price) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentScreen(serviceName: title, price: price),
      ),
    );
  }

  Widget _buildProductCard(String title, String price, String imagePath, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.cover),
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
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _navigateToQRPayment(context, title, price),
                  child: const Text("Beli"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Produk", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildProductCard("Pomade", "Rp.50.000", "assets/pomade.jpeg", context),
            _buildProductCard("Sisir Rambut", "Rp.20.000", "assets/sisir.jpeg", context),
            _buildProductCard("Powder", "Rp.30.000", "assets/powder.jpeg", context),
            _buildProductCard("pomade", "Rp.40.000", "assets/pomade1.png", context),
          ],
        ),
      ),
    );
  }
}
