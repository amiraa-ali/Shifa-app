import 'package:flutter/material.dart';
// import 'package:nav1/Booking.dart';
import 'package:nav1/Categories.dart';
import 'package:nav1/Doctorpage.dart';
import 'package:nav1/profile.dart';

final List<Map<String, dynamic>> homeCategoriesGrid = [
  {
    "name": "Cardiology",
    "icon": Icons.favorite,
    "color": Color(0xffE57373),
  },
  {
    "name": "Eyes",
    "icon": Icons.remove_red_eye,
    "color": Color(0xff64B5F6),
  },
  {
    "name": "Bones",
    "icon": Icons.accessibility_new,
    "color": Color(0xff81C784),
  },
  {
    "name": "Dermatology",
    "icon": Icons.face,
    "color": Color(0xffBA68C8),
  },
  {
    "name": "Dentist",
    "icon": Icons.medical_services,
    "color": Color(0xffFFD54F),
  },
  {
    "name": "Neurology",
    "icon": Icons.psychology,
    "color": Color(0xff4DD0E1),
  },
  // التخصصات الجديدة
  {
    "name": "Psychology",
    "icon": Icons.psychology_outlined,
    "color": Color(0xffFF8A65),
  },
  {
    "name": "Pediatrics",
    "icon": Icons.child_care,
    "color": Color(0xff4DB6AC),
  },
  {
    "name": "Orthopedics",
    "icon": Icons.fitness_center,
    "color": Color(0xff9575CD),
  },
  {
    "name": "ENT",
    "icon": Icons.hearing,
    "color": Color(0xffF06292),
  },
  {
    "name": "Gynecology",
    "icon": Icons.pregnant_woman,
    "color": Color(0xffFFB74D),
  },
  {
    "name": "General Surgery",
    "icon": Icons.medical_services_outlined,
    "color": Color(0xff4FC3F7),
  },
];


final List<Map<String, dynamic>> doctors = [
  {
    'name': 'Dr. Amira Ali',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. shorouk Abdelaleem',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. Wafaa Hamada',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. Doha Ahmed',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. Zeyad hassanien',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. Sarah Johnson',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. Mohamed Ali',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. Ahmed Ali',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
    {
    'name': 'Dr. Sarah Johnson',
    'specialty': 'Cardiologist',
    'rating': 4.9,
    'yearsExp': 12,
    'location': 'City Hospital',
    'distance': 2.5,
    'imagePath': 'assets/images/doc1.png',
  },
  {
    'name': 'Dr. Michael Chen',
    'specialty': 'Orthopedic Surgeon',
    'rating': 4.8,
    'yearsExp': 15,
    'location': 'Memorial Clinic',
    'distance': 1.8,
    'imagePath': 'assets/images/doc2.png',
  },
  {
    'name': 'Dr. Emily Roberts',
    'specialty': 'General Physician',
    'rating': 4.7,
    'yearsExp': 8,
    'location': 'Health Center',
    'distance': 3.1,
    'imagePath': 'assets/images/doc3.png',
  },
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreenContent(
        homeCategoriesGrid: homeCategoriesGrid,
        doctors: doctors,
      ), // Home
      const AllCategoriesPage(), // Bookings
      const ChatPage(), // Chat
      const ProfilePage(), // Profile
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_bottomNavIndex],
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _bottomNavIndex,
      onTap: (index) {
        setState(() => _bottomNavIndex = index);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
      iconSize: 28,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          activeIcon: Icon(Icons.book),
          label: "Bookings",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}

// -----------------
// محتوى صفحة Home مع تمرير البيانات
// -----------------
class HomeScreenContent extends StatelessWidget {
  final List<Map<String, dynamic>> homeCategoriesGrid;
  final List<Map<String, dynamic>> doctors;

  const HomeScreenContent({
    super.key,
    required this.homeCategoriesGrid,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeaderAndSearch(context),
          const SizedBox(height: 20),
          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllCategoriesPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: homeCategoriesGrid.length,
              separatorBuilder: (_, __) => const SizedBox(width: 15),
              itemBuilder: (context, index) {
                final item = homeCategoriesGrid[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorsPage(
                          categoryName: item["name"],
                          doctors: doctors,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [item["color"].withOpacity(0.8), item["color"]],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            item["icon"],
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item["name"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAndSearch(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2ECC71), Color(0xFF1ABC9C)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back,\nZeyad Hassanien',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 20),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Find your doctor or clinic...',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// -----------------
// chat page وهميه 
// -----------------
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Chat Page"));
  }
}
