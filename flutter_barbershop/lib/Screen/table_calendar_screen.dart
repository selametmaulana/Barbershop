import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'appointment_screen.dart';

class TableCalendarScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String service;
  final String product;
  final String price;
  final String idBooking; // Add idBooking as a required parameter

  const TableCalendarScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.service,
    required this.product,
    required this.price,
    required this.idBooking, // Pass idBooking to the constructor
  });

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';

  final List<String> timeSlots = [
    '08.00 AM',
    '08.15 AM',
    '09.30 AM',
    '09.45 AM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text("Business Men’s cool BarberShop"),
            ),
            Text(widget.price, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Date", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            _buildCalendar(),
            const SizedBox(height: 20),
            const Text("Select Time", style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: timeSlots.map((time) {
                final isSelected = selectedTime == time;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : const Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C2C2C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (selectedTime.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a time')),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScreen(
                        idBooking: widget.idBooking, // Pass idBooking
                        name: widget.name,
                        phone: widget.phone,
                        service: widget.service,
                        product: widget.product,
                        price: widget.price,
                        bookingDate: DateFormat('dd MMMM yyyy').format(selectedDate),
                        time: selectedTime,
                      ),
                    ),
                  );
                },
                child: const Text("Lanjut Pemesanan", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime(now.year, now.month, 1);
    DateTime lastDay = DateTime(now.year, now.month + 1, 0);

    List<Widget> dayWidgets = [];

    for (int i = 0; i < firstDay.weekday % 7; i++) {
      dayWidgets.add(const SizedBox(width: 40, height: 40));
    }

    for (int i = 1; i <= lastDay.day; i++) {
      final date = DateTime(now.year, now.month, i);
      final isSelected = selectedDate.day == i;

      dayWidgets.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedDate = date;
          });
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : const Color(0xFF2C2C2C),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$i',
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
            Text(
              DateFormat('MMMM').format(DateTime.now()),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: dayWidgets,
        ),
      ],
    );
  }
}
