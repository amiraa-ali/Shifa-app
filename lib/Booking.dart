import 'package:flutter/material.dart';
import 'homepage.dart';

// =========================================================
// Main App
// =========================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// =========================================================
// Book Appointment Page
// =========================================================
class BookAppointmentPage extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialty;
  final String clinicLocation;
  final String serviceType;
  final String totalAmount;

  const BookAppointmentPage({
    super.key,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.clinicLocation,
    required this.serviceType,
    required this.totalAmount,
  });

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  // =========================================================
  // STATE MANAGEMENT (Date & Time)
  // =========================================================
  String selectedTime = "04:30 PM";
  DateTime selectedDate = DateTime(2025, 11, 29);
  int currentStep = 1;

  int displayCount = 5;
  int startIndex = 0;
  int maxDays = 30;

  final List<String> times = [
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
  ];

  // =========================================================
  // STATE MANAGEMENT (Payment)
  // =========================================================
  bool cardSelected = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  // =========================================================
  // BOOKING INFORMATION
  // =========================================================
  late String doctorName;
  late String doctorSpecialty;
  late String clinicLocation;
  late String serviceType;
  late String totalAmount;
  String paymentMethod = "Credit Card";

  @override
  void initState() {
    super.initState();
    // تعيين بيانات الدكتور حسب القيم المستقبلة
    doctorName = widget.doctorName;
    doctorSpecialty = widget.doctorSpecialty;
    clinicLocation = widget.clinicLocation;
    serviceType = widget.serviceType;
    totalAmount = widget.totalAmount;

    centerSelectedDate(selectedDate);
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  // =========================================================
  // HELPER FUNCTIONS (Date & Time)
  // =========================================================
  List<DateTime> get dates =>
      List.generate(maxDays, (i) => DateTime.now().add(Duration(days: i)));

  String dayFormat(DateTime date) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[date.weekday - 1];
  }

  String dateFormat(DateTime date) {
    return date.day.toString().padLeft(2, '0');
  }

  void centerSelectedDate(DateTime date) {
    int center = displayCount ~/ 2;
    startIndex = dates.indexOf(date) - center;
    if (startIndex < 0) startIndex = 0;
    if (startIndex + displayCount > dates.length) {
      startIndex = dates.length - displayCount;
    }
  }

  // =========================================================
  // HELPER WIDGETS (Payment Step)
  // =========================================================
  Widget _buildPaymentOption({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    const activeColor = Color(0xff14B8A6);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected ? activeColor : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  color: selected ? activeColor : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Text(
            "Credit card details",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          _buildInputField(
            controller: cardNumberController,
            hint: "0000 0000 0000 0000",
            icon: Icons.credit_card,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Card number required";
              }
              if (value.replaceAll(" ", "").length != 16) {
                return "Card number must be 16 digits";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  controller: expiryDateController,
                  hint: "MM/YY",
                  icon: Icons.calendar_month,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Expiry required";
                    }
                    final regex = RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$");
                    if (!regex.hasMatch(value)) {
                      return "Invalid date format (MM/YY)";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildInputField(
                  controller: cvcController,
                  hint: "CVC",
                  icon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "CVC required";
                    }
                    if (value.length != 3) {
                      return "CVC must be 3 digits";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          icon: Icon(icon, color: Colors.grey),
        ),
      ),
    );
  }

  // =========================================================
  // MAIN BUILD METHOD
  // =========================================================
  @override
  Widget build(BuildContext context) {
    final visibleDates = dates.skip(startIndex).take(displayCount).toList();
    final screenHeight = MediaQuery.of(context).size.height;

    final appBar = _buildCustomAppBar(screenHeight, currentStep);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          appBar,
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StepIndicator(number: "1", text: "Date & Time", active: currentStep >= 1),
                StepIndicator(number: "2", text: "Payment", active: currentStep >= 2),
                StepIndicator(number: "3", text: "Summary", active: currentStep >= 3),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step 1: Date & Time
                  if (currentStep == 1) ...[
                    const Text("Select Date", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: startIndex > 0 ? () => setState(() => startIndex--) : null,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: visibleDates.map((d) {
                              bool isActive = d.day == selectedDate.day && d.month == selectedDate.month && d.year == selectedDate.year;
                              double width = isActive ? 60 : 50;
                              double height = isActive ? 80 : 70;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDate = d;
                                    centerSelectedDate(d);
                                  });
                                },
                                child: DateItem(day: dayFormat(d), date: dateFormat(d), active: isActive, width: width, height: height),
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: startIndex + displayCount < dates.length ? () => setState(() => startIndex++) : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text("Available Time", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: times.map((time) {
                        bool isActive = time == selectedTime;
                        return GestureDetector(
                          onTap: () => setState(() => selectedTime = time),
                          child: TimeItem(time: time, active: isActive),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 62,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                        ),
                        onPressed: () => setState(() => currentStep = 2),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(colors: [Color(0xff39ab4a), Color(0xff009f93)], begin: Alignment.bottomRight, end: Alignment.topLeft),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(minHeight: 62.0),
                            child: const Text("Continue", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // Step 2: Payment
                  if (currentStep == 2) ...[
                    const Text("Payment Options", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                    const SizedBox(height: 20),
                    _buildPaymentOption(title: "Cards", selected: cardSelected, onTap: () {
                      setState(() {
                        cardSelected = true;
                        paymentMethod = "Credit Card";
                      });
                    }),
                    if (cardSelected) _buildCardForm(),
                    const SizedBox(height: 20),
                    _buildPaymentOption(title: "Pay In Clinic", selected: !cardSelected, onTap: () {
                      setState(() {
                        cardSelected = false;
                        paymentMethod = "Pay In Clinic";
                      });
                    }),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 62,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
                        onPressed: () {
                          if (cardSelected && !_formKey.currentState!.validate()) return;
                          setState(() => currentStep = 3);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(colors: [Color(0xff39ab4a), Color(0xff009f93)], begin: Alignment.bottomRight, end: Alignment.topLeft),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(minHeight: 62.0),
                            child: const Text("Continue to Summary", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                  ],
                  // Step 3: Summary
                  if (currentStep == 3) ...[
                    SummaryStep(
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                      doctorName: doctorName,
                      doctorSpecialty: doctorSpecialty,
                      clinicLocation: clinicLocation,
                      serviceType: serviceType,
                      totalAmount: totalAmount,
                      paymentMethod: paymentMethod,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(double screenHeight, int currentStep) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.20,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        gradient: LinearGradient(
          colors: [Color(0xff39ab4a), Color(0xff009f93)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (currentStep > 1) setState(() => this.currentStep--);
                  else Navigator.of(context).maybePop();
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Center(
                  child: Text("Book Appointment", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// Step Indicator
// =========================================================
class StepIndicator extends StatelessWidget {
  final String number;
  final String text;
  final bool active;
  const StepIndicator({super.key, required this.number, required this.text, required this.active});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, color: active ? const Color(0xff14B8A6) : Colors.grey.shade300),
          child: Center(
            child: Text(number, style: TextStyle(color: active ? Colors.white : Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 8),
        Text(text, style: TextStyle(color: active ? const Color(0xff14B8A6) : Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// =========================================================
// DateItem
// =========================================================
class DateItem extends StatelessWidget {
  final String day;
  final String date;
  final bool active;
  final double width;
  final double height;
  const DateItem({super.key, required this.day, required this.date, required this.active, this.width = 50, this.height = 70});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      decoration: BoxDecoration(color: active ? const Color(0xff14B8A6) : const Color(0xffF2F4F7), borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day, style: TextStyle(color: active ? Colors.white : Colors.grey, fontSize: active ? 13 : 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(date, style: TextStyle(color: active ? Colors.white : Colors.black, fontSize: active ? 18 : 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// =========================================================
// TimeItem
// =========================================================
class TimeItem extends StatelessWidget {
  final String time;
  final bool active;
  const TimeItem({super.key, required this.time, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? const Color(0xff14B8A6) : const Color(0xffF2F4F7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(time, style: TextStyle(color: active ? Colors.white : Colors.grey, fontSize: 15)),
    );
  }
}


// // =========================================================
// Booking Summary Step (Redesigned)
// =========================================================
class SummaryStep extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String doctorName;
  final String doctorSpecialty;
  final String clinicLocation;
  final String serviceType;
  final String totalAmount;
  final String paymentMethod;

  const SummaryStep({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.clinicLocation,
    required this.serviceType,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    const cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    const titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    const valueStyle = TextStyle(color: Colors.grey, fontSize: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Booking Summary",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff009f93)),
        ),
        const SizedBox(height: 25),

        // Doctor Info
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Doctor", style: titleStyle),
                const SizedBox(height: 5),
                Text("$doctorName ($doctorSpecialty)", style: valueStyle),
              ],
            ),
          ),
        ),

        // Clinic Info
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Clinic", style: titleStyle),
                const SizedBox(height: 5),
                Text(clinicLocation, style: valueStyle),
              ],
            ),
          ),
        ),

        // Service Info
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Service", style: titleStyle),
                const SizedBox(height: 5),
                Text(serviceType, style: valueStyle),
              ],
            ),
          ),
        ),

        // Date & Time
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Date", style: titleStyle),
                    const SizedBox(height: 5),
                    Text(formattedDate, style: valueStyle),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Time", style: titleStyle),
                    const SizedBox(height: 5),
                    Text(selectedTime, style: valueStyle),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Payment Info
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 25),
          child: Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Payment Method", style: titleStyle),
                const SizedBox(height: 5),
                Text(paymentMethod, style: valueStyle),
                const SizedBox(height: 10),
                const Text("Total Amount", style: titleStyle),
                const SizedBox(height: 5),
                Text(
                  totalAmount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff009f93),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Confirm Button
        SizedBox(
  width: double.infinity,
  height: 62,
  child: TextButton(
    onPressed: () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Appointment Confirmed"),
          content: const Text("Your appointment has been successfully booked!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      );
    },
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xff39ab4a), Color(0xff009f93)],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: const Center(
        child: Text(
          "Confirm Appointment",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    ),
  ),
),

      ],
    );
  }
}

