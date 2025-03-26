import 'package:flutter/material.dart';
import 'package:flutter_barbershop/profil_user.dart';

void main() {
  runApp(BarberShopApp());
}

class BarberShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BarberShopScreen(),
    );
  }
}

class BarberShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[800],
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Business Men's cool BarberShop",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.white70),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Wirapanjunan, Kec. Kandanghaur, Kabupaten Indramayu, Jawa Barat",
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                      SizedBox(width: 5),
                      Text("3.7", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Text(
                        "Open",
                        style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.white24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Map", style: TextStyle(fontSize: 14, color: Colors.blueAccent)),
                      Text("Details", style: TextStyle(fontSize: 14)),
                      Stack(
                        children: [
                          Text("Staff", style: TextStyle(fontSize: 14)),
                          Positioned(
                            right: -10,
                            top: -5,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Text("1", style: TextStyle(fontSize: 10, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      Text("Certification", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gallery", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBarIndicator(
                          rating: 5,
                          itemBuilder: (context, index) => Icon(Icons.star, color: Colors.yellow),
                          itemCount: 5,
                          itemSize: 20,
                        ),
                        SizedBox(height: 5),
                        Text("Tq", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Airasyah", style: TextStyle(fontSize: 14, color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}