import 'package:flutter/material.dart';
import 'doctor_chat_screen.dart';
import 'doctor_profile.dart';

import 'appointment_screen.dart';

class Appointment {
  final String patientName;
  final String time;
  final String purpose;
  final String type;

  Appointment(this.patientName, this.time, this.purpose, this.type);
}

class DoctorHomeScreen extends StatefulWidget {
  final String doctorName;
  final String specialty;

  const DoctorHomeScreen({
    super.key,
    this.doctorName = 'Dr. Sarah Johnson',
    this.specialty = 'Cardiologist',
  });

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int index = 0;

  // Pages for bottom navigation
  final List<Widget> pages = [
    const SizedBox(), // Home handled manually
    DoctorChatScreen(), // Your real Chat Screen
    AppointmentsScreen(), // Your real Appointments Screen
    DoctorProfile(), // Your real Profile Screen
  ];

  final List<Appointment> todayAppointments = [
    Appointment('Emily Wilson', '09:00 AM', 'Follow-up Checkup', 'In-Clinic'),
    Appointment('James Anderson', '10:30 AM', 'Initial Consultation', 'Online'),
    Appointment('Sarah Martinez', '02:00 PM', 'ECG Test Results', 'In-Clinic'),
    Appointment('Michael Brown', '03:30 PM', 'Medication Review', 'Online'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      // ------------------- BOTTOM NAVIGATION -------------------
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() {
            index = i;
          });
        },
        height: 60,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Colors.teal),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat, color: Colors.teal),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today, color: Colors.teal),
            label: 'Appointments',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person, color: Colors.teal),
            label: 'Profile',
          ),
        ],
      ),

      // ------------------- BODY SWITCHING -------------------
      body: index == 0
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  _buildStatsGrid(),
                  _buildQuickActions(),
                  _buildTodayTasks(),
                  const SizedBox(height: 30),
                ],
              ),
            )
          : pages[index],
    );
  }

  // ------------------- UI SECTIONS -------------------

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1ABC9C), Color(0xFF2ECC71)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back,',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    widget.doctorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    'Thursday, October 23, 2025',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Text(
                  widget.doctorName.split(' ').map((e) => e[0]).join(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: const EdgeInsets.all(15),
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: <Widget>[
        _buildStatCard(
          icon: Icons.calendar_today,
          value: '8',
          label: 'Today\'s Appointments',
          color: const Color(0xFF1ABC9C),
        ),
        _buildStatCard(
          icon: Icons.watch_later_outlined,
          value: '24',
          label: 'Upcoming Bookings',
          color: Colors.blueAccent,
        ),
        _buildStatCard(
          icon: Icons.people_outline,
          value: '486',
          label: 'Total Patients',
          color: Colors.orange,
        ),
        _buildStatCard(
          icon: Icons.attach_money,
          value: '\$12,450',
          label: 'This Month Revenue',
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildActionButton(
                Icons.calendar_month,
                'View Schedule',
                const Color(0xFFD4EAE5),
              ),
              const SizedBox(width: 15),
              _buildActionButton(
                Icons.bar_chart,
                'Analytics',
                const Color(0xFFE5F5D4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF1ABC9C), size: 30),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayTasks() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Schedule',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF1ABC9C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          ...todayAppointments.map(
            (appointment) => _buildAppointmentItem(appointment),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(Appointment appointment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.access_time, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.patientName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                appointment.time,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: appointment.type == 'In-Clinic'
                      ? Colors.green.shade50
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  appointment.type,
                  style: TextStyle(
                    color: appointment.type == 'In-Clinic'
                        ? Colors.green.shade700
                        : Colors.blue.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                appointment.purpose,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
