import 'package:flutter/material.dart';
// import 'package:nav1/Booking.dart';
import 'package:nav1/Details.dart';
// import 'package:nav1/homepage.dart';
// import 'package:nav1/profile.dart';



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainAppScreen(),
//     );
//   }
// }

// class MainAppScreen extends StatefulWidget {
//   const MainAppScreen({super.key});

//   @override
//   State<MainAppScreen> createState() => _MainAppScreenState();
// }

// class _MainAppScreenState extends State<MainAppScreen> {
//   int _currentIndex = 0;

//   // Navigator Keys لكل صفحة
//   final _navigatorKeys = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];

//   // بيانات المستخدم
//   final List<Map<String, dynamic>> homeCategoriesGrid = [
//     {"name": "Cardiology", "icon": Icons.favorite, "color": Color(0xffE57373)},
//     {"name": "Eyes", "icon": Icons.remove_red_eye, "color": Color(0xff64B5F6)},
//     {"name": "Bones", "icon": Icons.accessibility_new, "color": Color(0xff81C784)},
//     {"name": "Dermatology", "icon": Icons.face, "color": Color(0xffBA68C8)},
//     {"name": "Dentist", "icon": Icons.medical_services, "color": Color(0xffFFD54F)},
//     {"name": "Neurology", "icon": Icons.psychology, "color": Color(0xff4DD0E1)},
//   ];

//   final List<Map<String, dynamic>> doctors = [
//     {'name': 'Dr. Ahmed Ali', 'specialty': 'Cardiologist'},
//     {'name': 'Dr. Sara Mahmoud', 'specialty': 'Cardiologist'},
//     {'name': 'Dr. Mohamed Mostafa', 'specialty': 'Cardiologist'},
//     {'name': 'Dr. Ahmed Ali', 'specialty': 'Cardiologist'},
//     {'name': 'Dr. Sara Mahmoud', 'specialty': 'Cardiologist'},
//     {'name': 'Dr. Mohamed Mostafa', 'specialty': 'Cardiologist'},
    
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: List.generate(_pages().length, (index) {
//           return Navigator(
//             key: _navigatorKeys[index],
//             onGenerateRoute: (settings) {
//               return MaterialPageRoute(builder: (_) => _pages()[index]);
//             },
//           );
//         }),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.teal,
//         unselectedItemColor: Colors.grey,
//         iconSize: 28,
//         onTap: (index) {
//           if (_currentIndex == index) {
//             _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
//           } else {
//             setState(() => _currentIndex = index);
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               activeIcon: Icon(Icons.home),
//               label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.book_outlined),
//               activeIcon: Icon(Icons.book),
//               label: "Bookings"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.chat_bubble_outline),
//               activeIcon: Icon(Icons.chat_bubble),
//               label: "Chat"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               activeIcon: Icon(Icons.person),
//               label: "Profile"),
//         ],
//       ),
//     );
//   }

//   List<Widget> _pages() {
//     return [
//       HomeScreen(),
//       const BookAppointmentPage(),
//       const ChatPage(),
//       const ProfilePage(),
//     ];
//   }
// }










// -----------------
// محتوى صفحة Home
// -----------------
// class HomeScreenContent extends StatelessWidget {
//   final List<Map<String, dynamic>> homeCategoriesGrid;
//   final List<Map<String, dynamic>> doctors;

//   const HomeScreenContent({super.key, required this.homeCategoriesGrid, required this.doctors});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           _buildHeaderAndSearch(context),
//           const SizedBox(height: 20),
//           // Categories
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 GestureDetector(
//                   onTap: () {},
//                   child: const Text('See All', style: TextStyle(color: Colors.blueAccent)),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           SizedBox(
//             height: 100,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               itemCount: homeCategoriesGrid.length,
//               separatorBuilder: (_, __) => const SizedBox(width: 15),
//               itemBuilder: (context, index) {
//                 final item = homeCategoriesGrid[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => DoctorsPage(
//                                   categoryName: item["name"],
//                                   doctors: doctors,
//                                 )));
//                   },
//                   child: Container(
//                     width: 80,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [item["color"].withOpacity(0.8), item["color"]],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             shape: BoxShape.circle,
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: Icon(item["icon"], color: Colors.white, size: 22),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(item["name"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderAndSearch(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(colors: [Color(0xFF2ECC71), Color(0xFF1ABC9C)]),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('Welcome back,\nZeyad Hassanien',
//               style: TextStyle(color: Colors.white, fontSize: 22)),
//           const SizedBox(height: 20),
//           Container(
//             height: 50,
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
//             child: const TextField(
//               decoration: InputDecoration(
//                 hintText: 'Find your doctor or clinic...',
//                 border: InputBorder.none,
//                 icon: Icon(Icons.search),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// -----------------
// صفحة دكاترة
// -----------------

class DoctorsPage extends StatelessWidget {
  final String categoryName;
  final List<Map<String, dynamic>> doctors;

  const DoctorsPage({super.key, required this.categoryName, required this.doctors});

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
                MaterialPageRoute(builder: (_) => DoctorDetailsPage(doctor: doctor)),
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
                            doctor['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            doctor['specialty'],
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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










