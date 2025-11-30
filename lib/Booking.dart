import 'package:flutter/material.dart';
import 'homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // تم تعيين الصفحة الافتراضية إلى خطوة "Date & Time" (currentStep = 1)
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookAppointmentPage(),
    );
  }
}

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  // =========================================================
  // STATE MANAGEMENT (Date & Time)
  // =========================================================

  String selectedTime = "04:30 PM";
  DateTime selectedDate = DateTime(2025, 11, 29); // 29 Nov 2025
  int currentStep = 1; // 1: Date & Time, 2: Payment, 3: Summary

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

  // تم نقلها من كود الدفع: الحالة الأساسية للدفع
  bool cardSelected = true;
  final _formKey = GlobalKey<FormState>();

  // تم نقلها من كود الدفع: متحكمات حقول البطاقة
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  // =========================================================
  // BOOKING INFORMATION (لخص صفحة Summary)
  // تم تحويل paymentMethod إلى mutable ليتم تحديثه بناءً على اختيار المستخدم
  // =========================================================

  final String doctorName = "Dr. Jack";
  final String doctorSpecialty = "Cardiologist";
  final String clinicLocation = "Downtown Clinic";
  final String serviceType = "General Checkup";
  final String totalAmount = "\$50";
  String paymentMethod = "Credit Card"; // تم جعله متغيرًا

  @override
  void initState() {
    super.initState();
    // لضمان أن التاريخ الافتراضي مرئيًا عند البداية
    centerSelectedDate(selectedDate);
  }

  @override
  void dispose() {
    // يجب التخلص من المتحكمات عند إغلاق الـ State
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
  // HELPER WIDGETS (Payment Step - تم نقلها من كود الدفع)
  // =========================================================

  Widget _buildPaymentOption({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    // تم توحيد اللون النشط ليتوافق مع لون التطبيق الأساسي (0xff14B8A6)
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
          /// ===== Upper Gradient Box with Curved Corners =====
          appBar,

          const SizedBox(height: 20),

          /// ===== Step Circles =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StepIndicator(
                  number: "1",
                  text: "Date & Time",
                  active: currentStep >= 1,
                ),
                StepIndicator(
                  number: "2",
                  text: "Payment",
                  active: currentStep >= 2,
                ),
                StepIndicator(
                  number: "3",
                  text: "Summary",
                  active: currentStep >= 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          /// ===== Content Below =====
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -----------------------------------------------------------
                  // Step 1: Date & Time
                  // -----------------------------------------------------------
                  if (currentStep == 1) ...[
                    const Text(
                      "Select Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: startIndex > 0
                              ? () => setState(() => startIndex--)
                              : null,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: visibleDates.map((d) {
                              bool isActive =
                                  d.day == selectedDate.day &&
                                  d.month == selectedDate.month &&
                                  d.year == selectedDate.year;
                              double width = isActive ? 60 : 50;
                              double height = isActive ? 80 : 70;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDate = d;
                                    centerSelectedDate(d);
                                  });
                                },
                                child: DateItem(
                                  day: dayFormat(d),
                                  date: dateFormat(d),
                                  active: isActive,
                                  width: width,
                                  height: height,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: startIndex + displayCount < dates.length
                              ? () => setState(() => startIndex++)
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    /// ===== Available Time =====
                    const Text(
                      "Available Time",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
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
                      // زر "Continue"
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            currentStep = 2; // Move to Payment step
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(
                              colors: [Color(0xff39ab4a), Color(0xff009f93)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(minHeight: 62.0),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],

                  // -----------------------------------------------------------
                  // Step 2: Payment
                  // -----------------------------------------------------------
                  if (currentStep == 2) ...[
                    const Text(
                      "Payment Options",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // خيار البطاقات (Cards)
                    _buildPaymentOption(
                      title: "Cards",
                      selected: cardSelected,
                      onTap: () {
                        setState(() {
                          cardSelected = true;
                          paymentMethod = "Credit Card"; // تحديث طريقة الدفع
                        });
                      },
                    ),

                    // عرض نموذج البطاقة إذا تم اختياره
                    if (cardSelected) _buildCardForm(),

                    const SizedBox(height: 20),

                    // خيار الدفع في العيادة (In The Clinic)
                    _buildPaymentOption(
                      title: "Pay In Clinic",
                      selected: !cardSelected,
                      onTap: () {
                        setState(() {
                          cardSelected = false;
                          paymentMethod = "Pay In Clinic"; // تحديث طريقة الدفع
                        });
                      },
                    ),

                    const SizedBox(height: 40),

                    // 🛑 تم حذف زر "Back to Date & Time" الرمادي من هنا

                    // زر المتابعة إلى الملخص
                    SizedBox(
                      width: double.infinity,
                      height: 62,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        onPressed: () {
                          // التحقق من صحة الفورم إذا كانت البطاقة مختارة
                          if (cardSelected &&
                              !_formKey.currentState!.validate()) {
                            return; // لا تنتقل إذا كان التحقق فاشلاً
                          }
                          setState(() {
                            currentStep = 3; // Move to Summary step
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(
                              colors: [Color(0xff39ab4a), Color(0xff009f93)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(minHeight: 62.0),
                            child: const Text(
                              "Continue to Summary",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],

                  // -----------------------------------------------------------
                  // Step 3: Summary
                  // -----------------------------------------------------------
                  if (currentStep == 3) ...[
                    // Summary step
                    SummaryStep(
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                      doctorName: doctorName,
                      doctorSpecialty: doctorSpecialty,
                      clinicLocation: clinicLocation,
                      serviceType: serviceType,
                      totalAmount: totalAmount,
                      paymentMethod: paymentMethod, // يمرر طريقة الدفع المحدثة
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

  /// دالة منفصلة لإنشاء شريط التطبيق المخصص (Upper Gradient Box with Curved Corners)
  Widget _buildCustomAppBar(double screenHeight, int currentStep) {
    return Container(
      width: double.infinity,
      // تم تعديل الارتفاع قليلاً ليتناسب مع الشكل الجديد
      height: screenHeight * 0.20,
      decoration: const BoxDecoration(
        // تطبيق الزوايا الدائرية على الأسفل فقط
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xff39ab4a), // اللون الأخضر الفاتح
            Color(0xff009f93), // اللون الفيروزي
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: SafeArea(
        child: Padding(
          // تطبيق التباعد المطلوب (horizontal: 19, vertical: 8.0)
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8.0),
          child: Row(
            children: [
              /// Back Button
              InkWell(
                onTap: () {
                  if (currentStep > 1) {
                    setState(() {
                      this.currentStep--;
                    });
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Center(
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
// تم حذف BottomCurveClipper
// =========================================================

class StepIndicator extends StatelessWidget {
  final String number;
  final String text;
  final bool active;
  const StepIndicator({
    super.key,
    required this.number,
    required this.text,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? const Color(0xff14B8A6) : Colors.grey.shade300,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: active ? Colors.white : Colors.grey.shade700,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            color: active ? const Color(0xff14B8A6) : Colors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class DateItem extends StatelessWidget {
  final String day;
  final String date;
  final bool active;
  final double width;
  final double height;

  const DateItem({
    super.key,
    required this.day,
    required this.date,
    required this.active,
    this.width = 50,
    this.height = 70,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: active ? const Color(0xff14B8A6) : const Color(0xffF2F4F7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey,
              fontSize: active ? 13 : 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            date,
            style: TextStyle(
              color: active ? Colors.white : Colors.black,
              fontSize: active ? 18 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

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
      child: Text(
        time,
        style: TextStyle(
          color: active ? Colors.white : Colors.grey,
          fontSize: 15,
        ),
      ),
    );
  }
}

// ===== Cards =====

class BookingInformationCard extends StatelessWidget {
  final DateTime date;
  final String time;
  final String location;
  final String service;

  const BookingInformationCard({
    super.key,
    required this.date,
    required this.time,
    required this.location,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Booking Information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildInfoRow(
              icon: Icons.calendar_today_outlined,
              label: "Date:",
              value:
                  "${date.day} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][date.month - 1]} ${date.year}",
            ),
            _buildInfoRow(icon: Icons.access_time, label: "Time:", value: time),
            _buildInfoRow(
              icon: Icons.location_on_outlined,
              label: "Location:",
              value: location,
            ),
            _buildInfoRow(
              icon: Icons.medical_services_outlined,
              label: "Service:",
              value: service,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 15, color: Colors.grey)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class DoctorInformationCard extends StatelessWidget {
  final String doctorName;
  final String specialty;

  const DoctorInformationCard({
    super.key,
    required this.doctorName,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Doctor Information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 30,
                  ), // Placeholder
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      specialty,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentInformationCard extends StatelessWidget {
  final String totalAmount;
  final String paymentMethod;

  const PaymentInformationCard({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildPaymentRow(
              icon: Icons.monetization_on_outlined,
              label: "Total Amount:",
              value: totalAmount,
            ),
            _buildPaymentRow(
              icon: Icons.credit_card,
              label: "Payment Method:",
              value: paymentMethod,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 15, color: Colors.grey)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// ===== Summary Step (تم تعديل زر التأكيد للانتقال إلى صفحة التأكيد الجديدة) =====
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
    return Column(
      children: [
        BookingInformationCard(
          date: selectedDate,
          time: selectedTime,
          location: clinicLocation,
          service: serviceType,
        ),
        const SizedBox(height: 20),
        DoctorInformationCard(
          doctorName: doctorName,
          specialty: doctorSpecialty,
        ),
        const SizedBox(height: 20),
        PaymentInformationCard(
          totalAmount: totalAmount,
          paymentMethod: paymentMethod,
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 62,
          // زر "Confirm Appointment" بتدرج الألوان
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            onPressed: () {
              // *** التعديل: الانتقال إلى AppointmentConfirmationPage ***
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AppointmentConfirmationPage(
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                    doctorName: doctorName,
                    doctorSpecialty: doctorSpecialty,
                  ),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [Color(0xff39ab4a), Color(0xff009f93)],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minHeight: 62.0),
                child: const Text(
                  "Confirm Appointment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ===== Appointment Confirmation Page (الصفحة الجديدة المطابقة للصورة) =====
class AppointmentConfirmationPage extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String doctorName;
  final String doctorSpecialty;

  const AppointmentConfirmationPage({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.doctorName,
    required this.doctorSpecialty,
  });

  // دالة مساعدة لإنشاء شريط التطبيق المخصص (Upper Gradient Box with Curved Corners)
  Widget _buildCustomAppBar(double screenHeight, BuildContext context) {
    return Container(
      width: double.infinity,
      // تم تعديل الارتفاع قليلاً ليتناسب مع الشكل الجديد
      height: screenHeight * 0.20,
      decoration: const BoxDecoration(
        // تطبيق الزوايا الدائرية على الأسفل فقط
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xff39ab4a), // اللون الأخضر الفاتح
            Color(0xff009f93), // اللون الفيروزي
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: SafeArea(
        child: Padding(
          // تطبيق التباعد المطلوب (horizontal: 19, vertical: 8.0)
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 8.0),
          child: Row(
            children: [
              /// Back Button (يعود إلى الشاشة السابقة - Summary Step)
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Center(
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // تهيئة التاريخ لعرضه كما في الصورة (29 Nov 2025)
    final dateString = "${selectedDate.day} Nov ${selectedDate.year}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // شريط التطبيق المخصص
          _buildCustomAppBar(screenHeight, context),

          const SizedBox(height: 20),

          // دوائر الخطوات (الخطوة 3 نشطة ومكتملة)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                StepIndicator(number: "1", text: "Date & Time", active: true),
                StepIndicator(number: "2", text: "Payment", active: true),
                StepIndicator(number: "3", text: "Summary", active: true),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // أيقونة التأكيد
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // لون الأيقونة يبقى كما هو لتناسق الخطوات
                      color: const Color(0xff14B8A6),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff14B8A6).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // رسالة التأكيد
                  const Text(
                    "Appointment Booked!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // تفاصيل الموعد
                  Text(
                    "Date: $dateString",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "Time: $selectedTime",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "Doctor: $doctorName ($doctorSpecialty)",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 100), // مسافة لدفع زر "Done" للأسفل
                ],
              ),
            ),
          ),

          // زر "Done"
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              height: 62,
              // زر "Done" بتدرج الألوان
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [Color(0xff39ab4a), Color(0xff009f93)],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minHeight: 62.0),
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// categories 
