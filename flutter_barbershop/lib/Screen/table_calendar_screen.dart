import 'package:flutter/material.dart';

void main() {
  runApp(BarbershopBookingApp());
}

class BarbershopBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingScreen(),
    );
  }
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  String? _selectedTime;
  
  List<String> availableTimes = ["08:00 AM", "08:15 AM", "09:30 AM", "09:45 AM"];

  // Fungsi untuk memilih tanggal
  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Business Men’s Cool BarberShop", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Date", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Align(
              alignment: Alignment.centerRight,
              child: Text("RM 60.00", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            SizedBox(height: 10),

            // Tombol Pilih Tanggal
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () => _pickDate(context),
              child: Text(
                _selectedDate == null 
                  ? "Pilih Tanggal" 
                  : "Tanggal: ${_selectedDate!.toLocal()}".split(' ')[0],
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 20),
            Text("Select Time", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // Pilihan Waktu
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: availableTimes.map((time) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedTime == time ? Colors.orange : Colors.grey[800],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onPressed: () {
                  setState(() {
                    _selectedTime = time;
                  });
                },
                child: Text(time, style: TextStyle(color: Colors.white)),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}