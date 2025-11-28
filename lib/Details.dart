import 'package:flutter/material.dart';
import 'package:nav1/Booking.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    const gradientColorStart = Color(0xff39ab4a);
    const gradientColorEnd = Color(0xff009f93);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // اسم الدكتور بشكل دائري في الأعلى
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [gradientColorStart, gradientColorEnd],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    doctor['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    doctor['specialty'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // محتوى الصفحة بالأسفل
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // وصف الدكتور
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'About Dr. ${doctor['name']}',style: TextStyle(   fontSize: 16,
                            color: gradientColorStart,
                            height: 1.5,
                            fontWeight: FontWeight.bold),
                         
                          ),
                        ),
                      
                        Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Dr. ${doctor['name']} is a highly experienced ${doctor['specialty']}. '
                          'He has been practicing for over 10 years and is known for his dedication and expertise. '
                          'He provides comprehensive care and ensures patient satisfaction with personalized treatment plans.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: gradientColorStart,
                            height: 1.5,
                           
                          ),
                        ),
                      ),
                      // مواقع العيادات
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          'Clinics Locations:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: gradientColorStart,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• 123 Main Street, City Center', style: TextStyle(color: gradientColorEnd)),
                            Text('• 45 Elm Street, Uptown', style: TextStyle(color: gradientColorEnd)),
                            Text('• 78 Oak Avenue, Downtown', style: TextStyle(color: gradientColorEnd)),
                          ],
                        ),
                      ),
                      // أوقات العمل
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          'Working Hours:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: gradientColorStart,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mon - Fri: 09:00 AM - 05:00 PM', style: TextStyle(color: gradientColorEnd)),
                            Text('Sat: 10:00 AM - 02:00 PM', style: TextStyle(color: gradientColorEnd)),
                            Text('Sun: Closed', style: TextStyle(color: gradientColorEnd)),
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gradientColorStart,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Book Appointment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const BookAppointmentPage()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
