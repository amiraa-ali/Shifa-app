import 'package:flutter/material.dart';

class Appointment {
  final String patientName;
  final String age;
  final String specialty;
  final String time;
  final String status;
  final double fees;
  final String bookingType;

  Appointment({
    required this.patientName,
    required this.age,
    required this.specialty,
    required this.time,
    required this.status,
    required this.fees,
    required this.bookingType,
  });
}

final List<Appointment> todayAppointments = [
  Appointment(
    patientName: "Ahmed ali",
    age: "34y",
    specialty: "Follow-up Checkup",
    time: "08:30 AM",
    status: "Active",
    fees: 570.0,
    bookingType: "Online",
  ),
  Appointment(
    patientName: "Ali Ahmed",
    age: "34y",
    specialty: "Follow-up Checkup",
    time: "08:30 AM",
    status: "Active",
    fees: 570.0,
    bookingType: "Online",
  ),
  Appointment(
    patientName: "Amir ali",
    age: "34y",
    specialty: "Follow-up Checkup",
    time: "08:30 AM",
    status: "Active",
    fees: 570.0,
    bookingType: "Online",
  ),
  Appointment(
    patientName: "Emily Wilson",
    age: "34y",
    specialty: "Follow-up Checkup",
    time: "07:00 AM",
    status: "Active",
    fees: 550.0,
    bookingType: "Online",
  ),
];

final List<Appointment> upcomingAppointments = [
  Appointment(
    patientName: "Lina Hassan",
    age: "55y",
    specialty: "Annual Health Check",
    time: "04:00 PM",
    status: "Upcoming",
    fees: 650.0,
    bookingType: "In Clinic",
  ),
  Appointment(
    patientName: "Amr",
    age: "34y",
    specialty: "Follow-up Checkup",
    time: "08:30 AM",
    status: "Active",
    fees: 570.0,
    bookingType: "Online",
  ),
];

final List<Appointment> completedAppointments = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentsScreen(),
    );
  }
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedIndex = 1;

  void onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildCustomAppBar(context),
        body: TabBarView(
          children: [
            AppointmentsList(appointments: todayAppointments),
            AppointmentsList(appointments: upcomingAppointments),
            AppointmentsList(appointments: completedAppointments),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////
  PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(140.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff39ab4a), Color(0xff009f93)],
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 19, vertical: 8.0),
                child: Column(
                  children: [
                    Text(
                      "Appointments",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "Manage your appointments",
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: "Today"),
                  Tab(text: "Upcoming"),
                  Tab(text: "Completed"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentsList extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentsList({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return const Center(
        child: Text(
          "No appointments here.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return AppointmentCard(appointment: appointments[index]);
      },
    );
  }
}

//
class AppointmentCard extends StatefulWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    bool isCompleted = completedAppointments.contains(widget.appointment);
    Color bookingColor = widget.appointment.bookingType == "Online"
        ? Colors.teal
        : Colors.green;
    String bookingText = widget.appointment.bookingType;

    String buttonLabel = isCompleted ? "Undone" : "Mark Done";
    IconData buttonIcon = isCompleted ? Icons.undo : Icons.check;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.appointment.patientName} - ${widget.appointment.age}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Fees: ${widget.appointment.fees.toStringAsFixed(0)} EGP',
                      style: TextStyle(
                        color: Colors.blueGrey.shade600,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                _buildStatusChip(bookingText, bookingColor),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              widget.appointment.specialty,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 10),
            const Divider(height: 1, color: Color(0xFFF0F0F0)),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.grey, size: 18),
                    const SizedBox(width: 5),
                    Text(
                      widget.appointment.time,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // ⭐ زرار Mark Done / Undone
                InkWell(
                  onTap: () {
                    setState(() {
                      if (!isCompleted) {
                        todayAppointments.remove(widget.appointment);
                        upcomingAppointments.remove(widget.appointment);
                        completedAppointments.add(widget.appointment);
                        Future.delayed(const Duration(milliseconds: 200), () {
                          DefaultTabController.of(context).animateTo(2);
                        });
                      } else {
                        completedAppointments.remove(widget.appointment);
                        todayAppointments.add(widget.appointment);
                        upcomingAppointments.add(widget.appointment);
                        Future.delayed(const Duration(milliseconds: 200), () {
                          DefaultTabController.of(context).animateTo(0);
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(buttonIcon, color: Colors.white, size: 16),
                        const SizedBox(width: 3),
                        Text(
                          buttonLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 3, backgroundColor: color),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
