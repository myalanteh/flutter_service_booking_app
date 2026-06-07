import 'package:flutter/material.dart';

void main() {
  runApp(const ServiceBookingApp());
}

class ServiceBookingApp extends StatelessWidget {
  const ServiceBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const BookingHomePage(),
    );
  }
}

class Booking {
  final String service;
  final String customerName;
  final String date;

  Booking({required this.service, required this.customerName, required this.date});
}

class BookingHomePage extends StatefulWidget {
  const BookingHomePage({super.key});

  @override
  State<BookingHomePage> createState() => _BookingHomePageState();
}

class _BookingHomePageState extends State<BookingHomePage> {
  final List<String> services = ['Website Fix', 'WordPress Setup', 'PHP Debugging', 'Website Migration'];
  final List<Booking> bookings = [
    Booking(service: 'Website Fix', customerName: 'Sample Client', date: 'Today'),
  ];

  void _bookService(String service) {
    final nameController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book $service'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Customer Name')),
            TextField(controller: dateController, decoration: const InputDecoration(labelText: 'Preferred Date')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && dateController.text.isNotEmpty) {
                setState(() {
                  bookings.insert(0, Booking(service: service, customerName: nameController.text, date: dateController.text));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Available Services', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...services.map((service) => Card(
              child: ListTile(
                leading: const Icon(Icons.build_circle_outlined),
                title: Text(service),
                subtitle: const Text('Tap to create a booking request'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _bookService(service),
              ),
            )),
            const SizedBox(height: 24),
            const Text('Bookings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (bookings.isEmpty) const Text('No bookings yet.'),
            ...bookings.map((booking) => Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.calendar_month)),
                title: Text(booking.customerName),
                subtitle: Text('${booking.service} • ${booking.date}'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
