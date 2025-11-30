import 'package:flutter/material.dart';
import 'Details.dart';
// import 'package:nav1/homepage.dart';
// import 'package:nav1/Details.dart';

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int yearsExp;
  final String location;
  final double distance;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.yearsExp,
    required this.location,
    required this.distance,
  });
}

final List<Doctor> doctors = [
  Doctor(
    name: 'Dr. Amira Ali',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. shorouk Abdelaleem',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. Wafaa Hamada',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. Doha Ahmed',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. Zeyad hassanien',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. Sarah Johnson',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. Mohamed Ali',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. Ahmed Ali',
    specialty: 'Cardiologist',
    rating: 4.9,
    yearsExp: 12,
    location: 'City Hospital',
    distance: 2.5,
  ),
  Doctor(
    name: 'Dr. Michael Chen',
    specialty: 'Orthopedic Surgeon',
    rating: 4.8,
    yearsExp: 15,
    location: 'Memorial Clinic',
    distance: 1.8,
  ),
  Doctor(
    name: 'Dr. Emily Roberts',
    specialty: 'General Physician',
    rating: 4.7,
    yearsExp: 8,
    location: 'Health Center',
    distance: 3.1,
  ),
];

class DoctorsPage extends StatelessWidget {
  final String categoryName;
  final List<Doctor> doctors;
  const DoctorsPage({
    super.key,
    required this.categoryName,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName Doctors'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff39ab4a), Color(0xff009f93)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DoctorDetailsPage(doctor: doctor),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 5,
              shadowColor: Colors.teal.withOpacity(0.3),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Color(0xff39ab4a), Color(0xff009f93)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 30, color: Colors.teal),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            doctor.specialty,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: const Text('Book'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DoctorDetailsPage(doctor: doctor),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
